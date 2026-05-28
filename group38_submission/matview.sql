CREATE MATERIALIZED VIEW mv_workload_cache AS
SELECT
    'monthly_revenue'::text AS cache_type,
    date_trunc('month', o.order_date)::date AS month_start,
    NULL::integer AS order_id,
    NULL::integer AS user_id,
    b.book_id,
    b.title,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    NULL::timestamp AS order_date,
    NULL::numeric(10,2) AS total_amount
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN books b ON b.book_id = oi.book_id
GROUP BY date_trunc('month', o.order_date)::date, b.book_id, b.title
UNION ALL
SELECT
    'review_purchase'::text AS cache_type,
    date_trunc('month', r.review_date)::date AS month_start,
    NULL::integer AS order_id,
    r.user_id,
    r.book_id,
    NULL::text AS title,
    NULL::numeric AS revenue,
    NULL::timestamp AS order_date,
    NULL::numeric(10,2) AS total_amount
FROM reviews r
WHERE EXISTS (
    SELECT 1
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.user_id = r.user_id
      AND oi.book_id = r.book_id
)
GROUP BY date_trunc('month', r.review_date)::date, r.user_id, r.book_id
UNION ALL
SELECT
    'review_stats_count'::text AS cache_type,
    NULL::date AS month_start,
    NULL::integer AS order_id,
    NULL::integer AS user_id,
    NULL::integer AS book_id,
    NULL::text AS title,
    COUNT(*)::numeric AS revenue,
    NULL::timestamp AS order_date,
    NULL::numeric(10,2) AS total_amount
FROM (
    SELECT book_id
    FROM reviews
    GROUP BY book_id
    HAVING COUNT(*) >= 10 AND AVG(rating) > 4.0
) sub
UNION ALL
SELECT
    'premium_order'::text AS cache_type,
    date_trunc('month', o.order_date)::date AS month_start,
    o.order_id,
    o.user_id,
    NULL::integer AS book_id,
    NULL::text AS title,
    NULL::numeric AS revenue,
    o.order_date,
    o.total_amount
FROM orders o
JOIN users u ON u.user_id = o.user_id
WHERE u.is_premium = TRUE;

CREATE INDEX idx_mv_workload_cache_lookup
    ON mv_workload_cache (cache_type, month_start, revenue DESC, order_date DESC)
    INCLUDE (order_id, user_id, book_id, title, total_amount);
