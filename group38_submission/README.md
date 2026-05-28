# Entrega Tarea 2 - Grupo 38

## Integrantes
- Completar nombres del grupo.

## Versiones usadas
- PostgreSQL: 18.3
- Python: 3.11
- Driver: psycopg2-binary

## Archivos
- `indexes.sql`: 3 indices sobre tablas base.
- `matview.sql`: 1 vista materializada combinada (`mv_workload_cache`) y 1 indice sobre ella.
- Total de indices creados: 4.
- `workload_after.sql`: copia de `workload.sql` con 15 reescrituras que consumen la vista materializada.
- `times_baseline.csv`: corrida caliente del workload original.
- `times_after.csv`: corrida caliente del workload optimizado.

## Reproduccion
Desde esta carpeta:

```bash
createdb bookstore_g38
psql -d bookstore_g38 -f schema.sql
psql -d bookstore_g38 -f load.sql
python run_workload.py --db bookstore_g38 --csv times_baseline_warmup.csv
python run_workload.py --db bookstore_g38 --csv times_baseline.csv
psql -d bookstore_g38 -f indexes.sql
psql -d bookstore_g38 -f matview.sql
psql -d bookstore_g38 -c "ANALYZE;"
python run_workload.py --db bookstore_g38 --workload workload_after.sql --csv times_after_warmup.csv
python run_workload.py --db bookstore_g38 --workload workload_after.sql --csv times_after.csv
```

## Resultado medido localmente
- Baseline caliente inicial: 13416 ms.
- After caliente con la estrategia final: 117 ms.
- Speedup aproximado final: 114.67x.
- Las 15 reescrituras fueron validadas con `EXCEPT` en ambos sentidos contra las consultas originales.
