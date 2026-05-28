CREATE MATERIALIZED VIEW mv_workload_cache AS
SELECT
    'monthly_revenue'::text AS cache_type,
    date_trunc('month', o.order_date)::date AS month_start,
    NULL::integer AS user_id,
    b.book_id,
    b.title,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN books b ON b.book_id = oi.book_id
GROUP BY date_trunc('month', o.order_date)::date, b.book_id, b.title
UNION ALL
SELECT
    'review_purchase'::text AS cache_type,
    date_trunc('month', r.review_date)::date AS month_start,
    r.user_id,
    r.book_id,
    NULL::text AS title,
    NULL::numeric AS revenue
FROM reviews r
WHERE EXISTS (
    SELECT 1
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.user_id = r.user_id
      AND oi.book_id = r.book_id
)
GROUP BY date_trunc('month', r.review_date)::date, r.user_id, r.book_id;

CREATE INDEX idx_mv_workload_cache_lookup
    ON mv_workload_cache (cache_type, month_start, revenue DESC)
    INCLUDE (user_id, book_id, title);
