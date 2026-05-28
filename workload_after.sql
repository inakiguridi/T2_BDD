-- Workload for group 38.
-- 100 queries sampled from 12 classes (Q01..Q12).
-- Each query is tagged with its class and an instance index so the
-- runner can aggregate timings by class.
--
-- You may add CREATE INDEX statements to speed these queries up.
-- For the materialization step, you may rewrite individual queries
-- to consume a MATERIALIZED VIEW you create -- but the rewritten
-- query MUST return the same result for the same parameters.

-- ===== 001 =====
SELECT user_id, is_premium
FROM users
WHERE LOWER(email) = LOWER('FATIMA.GUPTA166102@SHOP.NET');

-- ===== 002 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Hunte%'
ORDER BY title LIMIT 25;

-- ===== 003 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Broke%'
ORDER BY title LIMIT 25;

-- ===== 004 =====
SELECT book_id, title, revenue
FROM mv_workload_cache
WHERE cache_type = 'monthly_revenue'
  AND month_start = DATE '2024-10-01'
ORDER BY revenue DESC LIMIT 10;

-- ===== 005 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 14888
ORDER BY review_date DESC LIMIT 20;

-- ===== 006 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'The E%'
ORDER BY title LIMIT 25;

-- ===== 007 =====
UPDATE inventory
SET stock_count = stock_count - 1, last_updated = CURRENT_TIMESTAMP
WHERE book_id = 866 AND warehouse_id = 6;

-- ===== 008 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'maya.chen40697@mail.com';

-- ===== 009 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'Quincy.espinoza9794@example.org';

-- ===== 010 =====
SELECT book_id, title, revenue
FROM mv_workload_cache
WHERE cache_type = 'monthly_revenue'
  AND month_start = DATE '2023-11-01'
ORDER BY revenue DESC LIMIT 10;

-- ===== 011 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'luca.chen1173@shop.net';

-- ===== 012 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'cyrus.silva74524@example.org';

-- ===== 013 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 5903
ORDER BY review_date DESC LIMIT 20;

-- ===== 014 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Empir%'
ORDER BY title LIMIT 25;

-- ===== 015 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'kiri.rossi51762@books.io';

-- ===== 016 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Wolf %'
ORDER BY title LIMIT 25;

-- ===== 017 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 23167
ORDER BY review_date DESC LIMIT 20;

-- ===== 018 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'fatima.zhang17180@shop.net';

-- ===== 019 =====
SELECT o.order_id, o.user_id, o.order_date, o.total_amount
FROM orders o
JOIN users u ON u.user_id = o.user_id
WHERE u.is_premium = TRUE
  AND o.order_date >= '2021-06-01' AND o.order_date < '2021-06-08'
ORDER BY o.order_date DESC;

-- ===== 020 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Froze%'
ORDER BY title LIMIT 25;

-- ===== 021 =====
SELECT book_id, title, price, publication_year
FROM books
WHERE genre = 'fiction'
  AND price BETWEEN 10 AND 30
  AND publication_year >= 2018
ORDER BY publication_year DESC, price ASC LIMIT 50;

-- ===== 022 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 18200
ORDER BY review_date DESC LIMIT 20;

-- ===== 023 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'The D%'
ORDER BY title LIMIT 25;

-- ===== 024 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 13537
ORDER BY review_date DESC LIMIT 20;

-- ===== 025 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'The D%'
ORDER BY title LIMIT 25;

-- ===== 026 =====
SELECT order_id, user_id, order_date, total_amount
FROM orders
WHERE order_date >= '2024-10-01' AND order_date < '2024-11-01'
ORDER BY order_date DESC LIMIT 50;

-- ===== 027 =====
SELECT order_id, user_id, order_date, total_amount
FROM orders
WHERE order_date >= '2024-12-01' AND order_date < '2025-01-01'
ORDER BY order_date DESC LIMIT 50;

-- ===== 028 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'olga.IVANOV60532@books.io';

-- ===== 029 =====
SELECT o.order_id, o.user_id, o.order_date, o.total_amount
FROM orders o
JOIN users u ON u.user_id = o.user_id
WHERE u.is_premium = TRUE
  AND o.order_date >= '2021-09-08' AND o.order_date < '2021-09-15'
ORDER BY o.order_date DESC;

-- ===== 030 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'sven.hassan55690@books.io';

-- ===== 031 =====
SELECT o.order_id, o.user_id, o.order_date, o.total_amount
FROM orders o
JOIN users u ON u.user_id = o.user_id
WHERE u.is_premium = TRUE
  AND o.order_date >= '2024-06-15' AND o.order_date < '2024-06-22'
ORDER BY o.order_date DESC;

-- ===== 032 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 8319
ORDER BY review_date DESC LIMIT 20;

-- ===== 033 =====
SELECT book_id, title, price, publication_year
FROM books
WHERE genre = 'biography'
  AND price BETWEEN 5 AND 40
  AND publication_year >= 2020
ORDER BY publication_year DESC, price ASC LIMIT 50;

-- ===== 034 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'pablo.hassan193446@example.org';

-- ===== 035 =====
SELECT book_id, title, revenue
FROM mv_workload_cache
WHERE cache_type = 'monthly_revenue'
  AND month_start = DATE '2023-10-01'
ORDER BY revenue DESC LIMIT 10;

-- ===== 036 =====
UPDATE inventory
SET stock_count = stock_count - 1, last_updated = CURRENT_TIMESTAMP
WHERE book_id = 9300 AND warehouse_id = 6;

-- ===== 037 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 21511
ORDER BY review_date DESC LIMIT 20;

-- ===== 038 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'bianca.chen150187@mail.com';

-- ===== 039 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 8888
ORDER BY review_date DESC LIMIT 20;

-- ===== 040 =====
SELECT book_id, title, price, publication_year
FROM books
WHERE genre = 'history'
  AND price BETWEEN 20 AND 40
  AND publication_year >= 2021
ORDER BY publication_year DESC, price ASC LIMIT 50;

-- ===== 041 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'The L%'
ORDER BY title LIMIT 25;

-- ===== 042 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'Carla.alvarez92020@example.org';

-- ===== 043 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'Daniel.alvarez166121@example.org';

-- ===== 044 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'uma.ueda58624@mail.com';

-- ===== 045 =====
SELECT user_id, book_id
FROM mv_workload_cache
WHERE cache_type = 'review_purchase'
  AND month_start = DATE '2022-08-01';

-- ===== 046 =====
SELECT book_id, title, revenue
FROM mv_workload_cache
WHERE cache_type = 'monthly_revenue'
  AND month_start = DATE '2022-07-01'
ORDER BY revenue DESC LIMIT 10;

-- ===== 047 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Mirro%'
ORDER BY title LIMIT 25;

-- ===== 048 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Last %'
ORDER BY title LIMIT 25;

-- ===== 049 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 18851
ORDER BY review_date DESC LIMIT 20;

-- ===== 050 =====
SELECT book_id, title, revenue
FROM mv_workload_cache
WHERE cache_type = 'monthly_revenue'
  AND month_start = DATE '2024-01-01'
ORDER BY revenue DESC LIMIT 10;

-- ===== 051 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'maya.ivanov177330@example.org';

-- ===== 052 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'ines.okafor139163@shop.net';

-- ===== 053 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'Yusuf.ueda190729@mail.com';

-- ===== 054 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'arturo.jensen152997@shop.net';

-- ===== 055 =====
SELECT user_id, is_premium
FROM users
WHERE LOWER(email) = LOWER('QUINCY.JENSEN73395@EXAMPLE.ORG');

-- ===== 056 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'fatima.silva110911@example.org';

-- ===== 057 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'zara.moreno140943@books.io';

-- ===== 058 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'The E%'
ORDER BY title LIMIT 25;

-- ===== 059 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'tara.petrov65896@books.io';

-- ===== 060 =====
SELECT order_id, user_id, order_date, total_amount
FROM orders
WHERE order_date >= '2022-12-01' AND order_date < '2023-01-01'
ORDER BY order_date DESC LIMIT 50;

-- ===== 061 =====
SELECT user_id, is_premium
FROM users
WHERE LOWER(email) = LOWER('GRETA.OKAFOR68323@BOOKS.IO');

-- ===== 062 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'daniel.ferreira88648@mail.com';

-- ===== 063 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Heir %'
ORDER BY title LIMIT 25;

-- ===== 064 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 313
ORDER BY review_date DESC LIMIT 20;

-- ===== 065 =====
SELECT book_id, title, revenue
FROM mv_workload_cache
WHERE cache_type = 'monthly_revenue'
  AND month_start = DATE '2023-10-01'
ORDER BY revenue DESC LIMIT 10;

-- ===== 066 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'ines.ivanov66912@mail.com';

-- ===== 067 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'greta.tanaka106943@example.org';

-- ===== 068 =====
SELECT COUNT(*) FROM (
    SELECT book_id FROM reviews
    GROUP BY book_id
    HAVING COUNT(*) >= 10 AND AVG(rating) > 4.0
) sub;

-- ===== 069 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 20217
ORDER BY review_date DESC LIMIT 20;

-- ===== 070 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'maya.wagner28647@books.io';

-- ===== 071 =====
UPDATE inventory
SET stock_count = stock_count - 1, last_updated = CURRENT_TIMESTAMP
WHERE book_id = 21705 AND warehouse_id = 2;

-- ===== 072 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'sven.wagner41931@example.org';

-- ===== 073 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Garde%'
ORDER BY title LIMIT 25;

-- ===== 074 =====
SELECT book_id, title, price, publication_year
FROM books
WHERE genre = 'history'
  AND price BETWEEN 20 AND 40
  AND publication_year >= 2021
ORDER BY publication_year DESC, price ASC LIMIT 50;

-- ===== 075 =====
UPDATE inventory
SET stock_count = stock_count - 1, last_updated = CURRENT_TIMESTAMP
WHERE book_id = 10705 AND warehouse_id = 6;

-- ===== 076 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 14674
ORDER BY review_date DESC LIMIT 20;

-- ===== 077 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Mirro%'
ORDER BY title LIMIT 25;

-- ===== 078 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Ember%'
ORDER BY title LIMIT 25;

-- ===== 079 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 12476
ORDER BY review_date DESC LIMIT 20;

-- ===== 080 =====
SELECT book_id, title, revenue
FROM mv_workload_cache
WHERE cache_type = 'monthly_revenue'
  AND month_start = DATE '2021-07-01'
ORDER BY revenue DESC LIMIT 10;

-- ===== 081 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'yusuf.ferreira89328@books.io';

-- ===== 082 =====
SELECT book_id, title, revenue
FROM mv_workload_cache
WHERE cache_type = 'monthly_revenue'
  AND month_start = DATE '2024-04-01'
ORDER BY revenue DESC LIMIT 10;

-- ===== 083 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'Olga.brooks15226@shop.net';

-- ===== 084 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Crims%'
ORDER BY title LIMIT 25;

-- ===== 085 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 891
ORDER BY review_date DESC LIMIT 20;

-- ===== 086 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'fatima.yamamoto4456@mail.com';

-- ===== 087 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Ember%'
ORDER BY title LIMIT 25;

-- ===== 088 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'ben.zhang70101@books.io';

-- ===== 089 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'tara.JENSEN105219@mail.com';

-- ===== 090 =====
SELECT order_id, user_id, order_date, total_amount
FROM orders
WHERE order_date >= '2021-11-01' AND order_date < '2021-12-01'
ORDER BY order_date DESC LIMIT 50;

-- ===== 091 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 23432
ORDER BY review_date DESC LIMIT 20;

-- ===== 092 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'Rosa.xu163953@example.org';

-- ===== 093 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'hiro.wagner18042@books.io';

-- ===== 094 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Wolf %'
ORDER BY title LIMIT 25;

-- ===== 095 =====
SELECT review_id, user_id, rating, review_text, review_date
FROM reviews
WHERE book_id = 22026
ORDER BY review_date DESC LIMIT 20;

-- ===== 096 =====
SELECT user_id, book_id
FROM mv_workload_cache
WHERE cache_type = 'review_purchase'
  AND month_start = DATE '2024-02-01';

-- ===== 097 =====
SELECT user_id, is_premium, country
FROM users
WHERE email = 'victor.tanaka123942@shop.net';

-- ===== 098 =====
SELECT book_id, title, revenue
FROM mv_workload_cache
WHERE cache_type = 'monthly_revenue'
  AND month_start = DATE '2022-12-01'
ORDER BY revenue DESC LIMIT 10;

-- ===== 099 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Golde%'
ORDER BY title LIMIT 25;

-- ===== 100 =====
SELECT book_id, title, price
FROM books
WHERE title LIKE 'Empir%'
ORDER BY title LIMIT 25;
