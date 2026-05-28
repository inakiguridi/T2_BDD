#!/usr/bin/env python3
"""
Run the workload against your database and print the total wall-clock time.
This is the CANONICAL measurement for grading — all groups must use this
script (or one functionally identical to it) to produce T_student.

Usage:
    pip install psycopg2-binary
    python3 run_workload.py --db bookstore_g<N>

Optional:
    --workload <path>     run a different SQL file (e.g. workload_after.sql)
    --csv <path>          write per-query timings to a CSV (one row per query)

The script does NOT aggregate by class or print fancy summaries — that's your
job during profiling. Use --csv to dump per-query times and analyse them
however you want (sort, group, plot, etc.).

For exploring a single query's plan (not for the grading number), use:
    EXPLAIN (ANALYZE, BUFFERS) <query>;
or psql's `\\timing on`.
"""

import argparse
import re
import sys
import time
from pathlib import Path


HEADER_RE = re.compile(r"^--\s*=====\s*(\S+)\s*=====\s*$", re.MULTILINE)


def parse_workload(text):
    """Yield (label, sql) pairs in file order. The label is whatever follows
    `-- ===== ... =====`; we don't interpret it."""
    hits = list(HEADER_RE.finditer(text))
    out = []
    for i, m in enumerate(hits):
        label = m.group(1)
        start = m.end()
        end = hits[i + 1].start() if i + 1 < len(hits) else len(text)
        block = text[start:end]
        stmt = "\n".join(
            ln for ln in block.splitlines()
            if ln.strip() and not ln.strip().startswith("--")
        ).strip()
        if stmt.endswith(";"):
            stmt = stmt[:-1]
        if stmt:
            out.append((label, stmt))
    return out


def is_write(sql):
    return sql.lstrip().split(None, 1)[0].upper() in {"UPDATE", "INSERT", "DELETE"}


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--db",       required=True)
    ap.add_argument("--host",     default="localhost")
    ap.add_argument("--port",     default=5432, type=int)
    ap.add_argument("--user",     default=None)
    ap.add_argument("--password", default=None)
    ap.add_argument("--workload", type=Path, default=Path("workload.sql"),
                    help="Path to the SQL file (default: ./workload.sql)")
    ap.add_argument("--csv",      type=Path, default=None,
                    help="If given, write per-query timings to this CSV.")
    args = ap.parse_args()

    try:
        import psycopg2
    except ImportError:
        sys.exit("psycopg2 not installed. Run:  pip install psycopg2-binary")

    if not args.workload.exists():
        sys.exit(f"workload file not found: {args.workload}")

    queries = parse_workload(args.workload.read_text())
    if not queries:
        sys.exit("No queries parsed from the workload file.")

    conn = psycopg2.connect(dbname=args.db, host=args.host, port=args.port,
                            user=args.user, password=args.password)
    conn.autocommit = False
    cur = conn.cursor()

    print(f"Connected to {args.db}.  Running {len(queries)} queries from {args.workload}.")

    # Run.
    timings = []  # list of (label, elapsed_seconds)
    t_start = time.perf_counter()
    for label, sql in queries:
        wrote = is_write(sql)
        if wrote:
            cur.execute("SAVEPOINT sp_run")
        t0 = time.perf_counter()
        try:
            cur.execute(sql)
            if cur.description is not None:
                cur.fetchall()
        except Exception as e:
            conn.rollback()
            print(f"  ERROR on {label}: {e}", file=sys.stderr)
            timings.append((label, float("nan")))
            continue
        elapsed = time.perf_counter() - t0
        if wrote:
            cur.execute("ROLLBACK TO SAVEPOINT sp_run")
        timings.append((label, elapsed))
    conn.rollback()
    t_total = time.perf_counter() - t_start

    print()
    print(f"  >>>  T_workload = {t_total * 1000:.0f} ms  <<<")
    print()

    if args.csv:
        with open(args.csv, "w") as f:
            f.write("label,elapsed_ms\n")
            for label, elapsed in timings:
                f.write(f"{label},{elapsed * 1000:.3f}\n")
        print(f"Wrote per-query timings to {args.csv}")

    cur.close()
    conn.close()


if __name__ == "__main__":
    main()
