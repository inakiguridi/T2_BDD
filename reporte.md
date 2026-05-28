# Reporte Tarea 2 - Grupo 38

## Paso 1 - Linea base y analisis de workload
Se corrio el workload original dos veces sobre una base recien cargada y analizada. La segunda corrida caliente dio T_workload = 13416 ms.

La carga se concentra en dos familias: (1) consultas review-compra con EXISTS sobre reviews, orders y order_items, que suman 5351.690 ms en solo 2 consultas; (2) rankings mensuales de ingresos por libro, que suman 4732.485 ms en 9 consultas. Luego aparecen reviews por libro, ordenes por fecha, ordenes premium y busquedas case-insensitive por email.

## Paso 2 - Indices
Se usaron 4 indices sobre tablas base:

1. idx_users_lower_email: acelera las 3 busquedas con LOWER(email).
2. idx_reviews_book_date_desc: acelera las 16 consultas de ultimas reviews por book_id ordenadas por review_date DESC.
3. idx_orders_order_date_desc: acelera ventanas por fecha en orders y permite index-only scans para consultas de ordenes por mes.
4. idx_books_title_pattern: acelera las 21 busquedas por prefijo title LIKE '...%' con text_pattern_ops.

## Paso 3 - Vista materializada
Se creo una sola vista materializada, mv_workload_cache, con dos tipos de filas diferenciadas por cache_type:

- monthly_revenue: precalcula revenue mensual por libro para responder los rankings top 10.
- review_purchase: precalcula pares (mes, user_id, book_id) donde un usuario hizo review de un libro que compro.

Esto respeta la restriccion de una sola matview y permite reescribir 11 consultas del workload para consumirla. Las reescrituras fueron validadas con EXCEPT en ambos sentidos; todas dieron diferencia 0.

## Paso 4 - Mediciones finales
Sobre una base fresca con solo indexes.sql y matview.sql aplicados, se corrio workload_after.sql dos veces. La segunda corrida caliente dio T_workload = 489 ms.

Speedup aproximado: 27.44x.
