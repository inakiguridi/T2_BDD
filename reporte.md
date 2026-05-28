# Reporte Tarea 2 - Grupo 38

## Paso 1 - Linea base y analisis de workload
Se corrio el workload original dos veces sobre una base recien cargada y analizada. La segunda corrida caliente dio T_workload = 13416 ms.

La carga se concentraba en review-compra, rankings mensuales de ingresos, reviews por libro, ordenes premium, ordenes por fecha y busquedas por email/titulo.

## Paso 2 - Indices
Se usaron 4 indices sobre tablas base: LOWER(email), reviews(book_id, review_date DESC), orders(order_date DESC) con columnas incluidas y books(title text_pattern_ops) con columnas incluidas.

## Paso 3 - Vista materializada
Se creo una sola vista materializada, mv_workload_cache, con cache_type para almacenar cuatro familias de resultados: monthly_revenue, review_purchase, review_stats_count y premium_order. Esto permite reescribir 15 consultas sin romper la restriccion de una sola matview.

Las reescrituras fueron validadas con EXCEPT en ambos sentidos; todas dieron diferencia 0.

## Paso 4 - Mediciones finales
Sobre una base fresca con solo indexes.sql y matview.sql aplicados, se corrio workload_after.sql dos veces. La segunda corrida caliente dio T_workload = 61 ms.

Speedup aproximado: 219.93x.
