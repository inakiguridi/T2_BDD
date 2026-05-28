-- Bookstore schema for DB course assignment.
-- TEXT with VARCHAR(n), and TIMESTAMP default syntax accordingly.

DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS inventory CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS authors CASCADE;
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
    user_id      SERIAL PRIMARY KEY,
    email        TEXT NOT NULL UNIQUE,
    signup_date  DATE NOT NULL,
    country      TEXT,                 -- nullable on purpose
    is_premium   BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE authors (
    author_id    SERIAL PRIMARY KEY,
    name         TEXT NOT NULL,
    country      TEXT,
    birth_year   INTEGER
);

CREATE TABLE books (
    book_id           SERIAL PRIMARY KEY,
    title             TEXT NOT NULL,
    author_id         INTEGER NOT NULL REFERENCES authors(author_id),
    genre             TEXT NOT NULL,
    price             NUMERIC(6,2) NOT NULL,
    publication_year  INTEGER,
    page_count        INTEGER,          -- nullable
    isbn              TEXT NOT NULL     -- formatting inconsistent on purpose
);

CREATE TABLE inventory (
    book_id       INTEGER NOT NULL REFERENCES books(book_id),
    warehouse_id  INTEGER NOT NULL,
    stock_count   INTEGER NOT NULL,
    last_updated  TIMESTAMP NOT NULL,
    PRIMARY KEY (book_id, warehouse_id)
);

CREATE TABLE orders (
    order_id      SERIAL PRIMARY KEY,
    user_id       INTEGER NOT NULL REFERENCES users(user_id),
    order_date    TIMESTAMP NOT NULL,
    status        TEXT NOT NULL,
    total_amount  NUMERIC(10,2) NOT NULL
);

CREATE TABLE order_items (
    order_id      INTEGER NOT NULL REFERENCES orders(order_id),
    book_id       INTEGER NOT NULL REFERENCES books(book_id),
    quantity      INTEGER NOT NULL,
    unit_price    NUMERIC(6,2) NOT NULL,
    PRIMARY KEY (order_id, book_id)
);

CREATE TABLE reviews (
    review_id     SERIAL PRIMARY KEY,
    book_id       INTEGER NOT NULL REFERENCES books(book_id),
    user_id       INTEGER NOT NULL REFERENCES users(user_id),
    rating        INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text   TEXT,
    review_date   TIMESTAMP NOT NULL,
    helpful_count INTEGER NOT NULL DEFAULT 0
);

-- After loading, students should run ANALYZE to update statistics.
