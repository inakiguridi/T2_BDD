CREATE INDEX idx_users_lower_email ON users (LOWER(email));
CREATE INDEX idx_reviews_book_date_desc ON reviews (book_id, review_date DESC);
CREATE INDEX idx_orders_order_date_desc ON orders (order_date DESC) INCLUDE (order_id, user_id, total_amount);
CREATE INDEX idx_books_title_pattern ON books (title text_pattern_ops) INCLUDE (book_id, price);
