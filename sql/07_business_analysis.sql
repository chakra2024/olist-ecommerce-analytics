-- =============================================================
-- OLIST E-COMMERCE BUSINESS ANALYSIS
-- =============================================================
--
-- Purpose:
-- This file contains business-focused SQL analyses on the
-- Olist e-commerce dataset.
--
-- Objectives:
-- 1. Understand business performance
-- 2. Analyze customers and sellers
-- 3. Study products and categories
-- 4. Evaluate revenue and payments
-- 5. Examine delivery performance
-- 6. Analyze customer reviews
--
-- Author: Soham Chakraborty
-- =============================================================

-- =============================================================
-- 1. OVERALL BUSINESS SUMMARY
-- =============================================================
--
-- Business Question:
-- What is the overall size of the business?
--
-- This query returns:
-- • Total delivered orders
-- • Unique customers
-- • Active sellers
-- • Products sold
-- • Product revenue (Here it is sum of price, as no quantity column present and multiple records of order id present)
-- • Freight revenue
-- • Total sales value
-- =============================================================

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_unique_id) AS unique_customers,
    COUNT(DISTINCT oi.product_id) AS products_sold,
    COUNT(DISTINCT oi.seller_id) AS active_sellers,

    ROUND(SUM(oi.price),2) AS product_revenue,

    ROUND(SUM(oi.freight_value),2) AS freight_revenue,

    ROUND(SUM(oi.price + oi.freight_value),2) AS total_sales

FROM olist.orders o

JOIN olist.customers c
ON o.customer_id = c.customer_id

JOIN olist.order_items oi
ON o.order_id = oi.order_id

WHERE o.order_status='delivered';

-- =============================================================
-- 2. ORDER STATUS ANALYSIS
-- =============================================================
--
-- Business Question:
-- How many orders fall into each order status?
--
-- This helps evaluate operational performance and identify
-- cancelled or delayed orders.
-- =============================================================

SELECT

    order_status,

    COUNT(*) AS total_orders,

    ROUND(
        COUNT(*)*100.0/
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage

FROM olist.orders

GROUP BY order_status

ORDER BY total_orders DESC;

-- =============================================================
-- 3. MONTHLY SALES TREND
-- =============================================================
--
-- Business Question:
-- How has the business grown over time?
--
-- This query calculates monthly sales and revenue.
-- =============================================================

SELECT

    DATE_TRUNC('month',o.order_purchase_timestamp) AS month,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(SUM(oi.price),2) AS revenue

FROM olist.orders o

JOIN olist.order_items oi
ON o.order_id=oi.order_id

WHERE o.order_status='delivered'

GROUP BY month

ORDER BY month;

-- =============================================================
-- 4. TOP STATES BY REVENUE
-- =============================================================
--
-- Business Question:
-- Which states generate the highest revenue?
--
-- Helps identify the strongest customer markets.
-- =============================================================

SELECT

    c.customer_state,

    ROUND(SUM(oi.price),2) AS revenue,

    COUNT(DISTINCT o.order_id) AS orders

FROM olist.customers c

JOIN olist.orders o
ON c.customer_id=o.customer_id

JOIN olist.order_items oi
ON o.order_id=oi.order_id

WHERE o.order_status='delivered'

GROUP BY c.customer_state

ORDER BY revenue DESC;

-- =============================================================
-- 5. TOP PRODUCT CATEGORIES
-- =============================================================
--
-- Business Question:
-- Which product categories generate the highest revenue?
--
-- Category names are translated into English using the
-- category_translation table.
-- =============================================================

SELECT

    ct.product_category_name_english,

    COUNT(*) AS items_sold,

    ROUND(SUM(oi.price),2) AS revenue

FROM olist.products p

JOIN olist.order_items oi
ON p.product_id=oi.product_id

LEFT JOIN olist.category_translation ct
ON p.product_category_name=ct.product_category_name

GROUP BY ct.product_category_name_english

ORDER BY revenue DESC

LIMIT 10;

-- =============================================================
-- 6. TOP SELLERS BY REVENUE
-- =============================================================
--
-- Business Question:
-- Which sellers generate the highest revenue?
--
-- Helps identify the most successful marketplace sellers.
-- =============================================================

SELECT

    seller_id,

    COUNT(*) AS items_sold,

    ROUND(SUM(price),2) AS revenue

FROM olist.order_items

GROUP BY seller_id

ORDER BY revenue DESC

LIMIT 10;

-- =============================================================
-- 7. REVIEW SCORE DISTRIBUTION
-- =============================================================
--
-- Business Question:
-- How satisfied are customers?
--
-- Counts the number of reviews for each rating.
-- =============================================================

SELECT

    review_score,

    COUNT(*) AS total_reviews

FROM olist.reviews

GROUP BY review_score

ORDER BY review_score;

-- =============================================================
-- 8. PAYMENT METHODS
-- =============================================================
--
-- Business Question:
-- Which payment methods are most popular?
-- =============================================================

SELECT

    payment_type,

    COUNT(*) AS transactions,

    ROUND(SUM(payment_value),2) AS total_paid

FROM olist.payments

GROUP BY payment_type

ORDER BY total_paid DESC;

-- =============================================================
-- 9. DELIVERY PERFORMANCE
-- =============================================================
--
-- Business Question:
-- How many days does delivery take on average?
--
-- Measures the average time between purchase and delivery.
-- =============================================================

SELECT
    ROUND(
        AVG(
            order_delivered_customer_date::date
            - order_purchase_timestamp::date
        ),
        2
    ) AS avg_delivery_days
FROM olist.orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;