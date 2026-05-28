-- Load data for group 38.
-- Run AFTER schema.sql, from THIS directory so the relative data/ paths work:
--
--   cd <this directory>
--   createdb bookstore_g38
--   psql -d bookstore_g38 -f schema.sql
--   psql -d bookstore_g38 -f load.sql

BEGIN;

\copy users       FROM 'data/users.csv'       WITH (FORMAT csv, HEADER true, NULL '')
\copy authors     FROM 'data/authors.csv'     WITH (FORMAT csv, HEADER true, NULL '')
\copy books       FROM 'data/books.csv'       WITH (FORMAT csv, HEADER true, NULL '')
\copy inventory   FROM 'data/inventory.csv'   WITH (FORMAT csv, HEADER true, NULL '')
\copy orders      FROM 'data/orders.csv'      WITH (FORMAT csv, HEADER true, NULL '')
\copy order_items FROM 'data/order_items.csv' WITH (FORMAT csv, HEADER true, NULL '')
\copy reviews     FROM 'data/reviews.csv'     WITH (FORMAT csv, HEADER true, NULL '')

-- \copy does not advance SERIAL sequences. Bump them past the loaded max so
-- that any later INSERT into these tables doesn't collide on the primary key.
SELECT setval(pg_get_serial_sequence('users',   'user_id'),   (SELECT MAX(user_id)   FROM users));
SELECT setval(pg_get_serial_sequence('authors', 'author_id'), (SELECT MAX(author_id) FROM authors));
SELECT setval(pg_get_serial_sequence('books',   'book_id'),   (SELECT MAX(book_id)   FROM books));
SELECT setval(pg_get_serial_sequence('orders',  'order_id'),  (SELECT MAX(order_id)  FROM orders));
SELECT setval(pg_get_serial_sequence('reviews', 'review_id'), (SELECT MAX(review_id) FROM reviews));

COMMIT;

-- Refresh planner statistics after the bulk load.
ANALYZE;
