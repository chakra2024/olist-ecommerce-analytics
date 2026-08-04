-- =====================================================
-- OLIST TABLES
-- =====================================================

SET search_path TO olist;

-- ==========================
-- Customers
-- ==========================
CREATE TABLE IF NOT EXISTS olist.customers (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(5),
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);

-- ==========================
-- Orders
-- ==========================
CREATE TABLE IF NOT EXISTS olist.orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- ==========================
-- Order Items 
-- Note: freight value represents shipping and handling cost
-- ==========================
CREATE TABLE IF NOT EXISTS olist.order_items (
    order_id VARCHAR(50),
    order_item_id INTEGER,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10,2),
    freight_value NUMERIC(10,2) 
);

-- ==========================
-- Products
-- ==========================
CREATE TABLE IF NOT EXISTS olist.products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_length NUMERIC(10,0),
    product_description_length NUMERIC(10,0),
    product_photos_qty NUMERIC(10,0),
    product_weight_g NUMERIC,
    product_length_cm NUMERIC,
    product_height_cm NUMERIC,
    product_width_cm NUMERIC
);

-- ==========================
-- Sellers
-- ==========================
CREATE TABLE IF NOT EXISTS olist.sellers (
    seller_id VARCHAR(50),
    seller_zip_code_prefix VARCHAR(5),
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);

-- ==========================
-- Payments
-- ==========================
CREATE TABLE IF NOT EXISTS olist.payments (
    order_id VARCHAR(50),
    payment_sequential INTEGER,
    payment_type VARCHAR(30),
    payment_installments INTEGER,
    payment_value NUMERIC(10,2)
);

-- ==========================
-- Reviews
-- ==========================
CREATE TABLE IF NOT EXISTS olist.reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATE,
    review_answer_timestamp TIMESTAMP
);

-- ==========================
-- Geolocation
-- ==========================
CREATE TABLE IF NOT EXISTS olist.geolocation (
    geolocation_zip_code_prefix VARCHAR(5),
    geolocation_lat NUMERIC(10,7),
    geolocation_lng NUMERIC(10,7),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);

-- ==========================
-- Translation Table
-- ==========================

CREATE TABLE IF NOT EXISTS olist.category_translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);