-- ============================================================
-- Validate relationships between Olist tables
-- A result of 0 means no unmatched foreign-key records exist.
-- ============================================================

-- Orders without a matching customer
SELECT
    'orders → customers' AS relationship,
    COUNT(*) AS unmatched_rows
FROM olist.orders o
LEFT JOIN olist.customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL

UNION ALL

-- Order items without a matching order
SELECT
    'order_items → orders',
    COUNT(*)
FROM olist.order_items oi
LEFT JOIN olist.orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL

UNION ALL

-- Order items without a matching product
SELECT
    'order_items → products',
    COUNT(*)
FROM olist.order_items oi
LEFT JOIN olist.products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL

UNION ALL

-- Order items without a matching seller
SELECT
    'order_items → sellers',
    COUNT(*)
FROM olist.order_items oi
LEFT JOIN olist.sellers s
    ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL

UNION ALL

-- Payments without a matching order
SELECT
    'payments → orders',
    COUNT(*)
FROM olist.payments p
LEFT JOIN olist.orders o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL

UNION ALL

-- Reviews without a matching order
SELECT
    'reviews → orders',
    COUNT(*)
FROM olist.reviews r
LEFT JOIN olist.orders o
    ON r.order_id = o.order_id
WHERE o.order_id IS NULL;


-- Product categories without an English translation
SELECT
    p.product_category_name,
    COUNT(*) AS product_count
FROM olist.products p
LEFT JOIN olist.category_translation ct
    ON p.product_category_name = ct.product_category_name
WHERE p.product_category_name IS NOT NULL
  AND ct.product_category_name IS NULL
GROUP BY p.product_category_name
ORDER BY product_count DESC;