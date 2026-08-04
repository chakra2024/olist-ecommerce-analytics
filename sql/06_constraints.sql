-- ====================================================
-- PRIMARY KEYS
-- did not create primary key for geolocation table, as it has duplicates and its just a translation table.
-- ====================================================

ALTER TABLE olist.customers
ADD PRIMARY KEY (customer_id);

ALTER TABLE olist.orders
ADD PRIMARY KEY (order_id);

ALTER TABLE olist.products
ADD PRIMARY KEY (product_id);

ALTER TABLE olist.sellers
ADD PRIMARY KEY (seller_id);

ALTER TABLE olist.category_translation
ADD PRIMARY KEY (product_category_name);

ALTER TABLE olist.order_items
ADD PRIMARY KEY (
    order_id,
    order_item_id
);

ALTER TABLE olist.payments
ADD PRIMARY KEY (
    order_id,
    payment_sequential
);

ALTER TABLE olist.reviews
ADD PRIMARY KEY (
    review_id,
    order_id
);

-- ====================================================
-- FOREIGN KEYS
-- ====================================================

ALTER TABLE olist.orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES olist.customers(customer_id);

ALTER TABLE olist.order_items
ADD CONSTRAINT fk_orderitems_orders
FOREIGN KEY (order_id)
REFERENCES olist.orders(order_id);

ALTER TABLE olist.order_items
ADD CONSTRAINT fk_orderitems_products
FOREIGN KEY (product_id)
REFERENCES olist.products(product_id);

ALTER TABLE olist.order_items
ADD CONSTRAINT fk_orderitems_sellers
FOREIGN KEY (seller_id)
REFERENCES olist.sellers(seller_id);

ALTER TABLE olist.payments
ADD CONSTRAINT fk_payments_orders
FOREIGN KEY (order_id)
REFERENCES olist.orders(order_id);

ALTER TABLE olist.reviews
ADD CONSTRAINT fk_reviews_orders
FOREIGN KEY (order_id)
REFERENCES olist.orders(order_id);

-- ALTER TABLE olist.products
-- ADD CONSTRAINT fk_products_translation
-- FOREIGN KEY (product_category_name)
-- REFERENCES olist.category_translation(product_category_name);