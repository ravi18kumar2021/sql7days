use sql7challenge;

-- 1. Total sales value
-- calculate the total value of all order items.
SELECT SUM(oi.quantity * oi.unit_price) AS total_sales
FROM order_items oi
INNER JOIN orders o
ON oi.order_id = o.order_id
WHERE status <> 'cancelled';

-- 2. Revenue by product category
-- identify which product categories generate the most sales
SELECT p.category, SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
INNER JOIN order_items oi
ON p.product_id = oi.product_id
INNER JOIN orders o
ON oi.order_id = o.order_id
WHERE o.status <> 'cancelled'
GROUP BY p.category
ORDER BY revenue DESC;

-- 3. Top 10 products by revenue
-- find top 10 products generating the highest revenue
SELECT p.product_name, SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
INNER JOIN order_items oi
ON p.product_id = oi.product_id
INNER JOIN orders o
ON oi.order_id = o.order_id
WHERE o.status <> 'cancelled'
GROUP BY p.product_name
ORDER BY revenue DESC;

-- 4. Monthly revenue trend
-- calculate revenue month by month
SELECT YEAR(o.order_date) AS Year, MONTHNAME(o.order_date) AS Month, SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
INNER JOIN order_items oi
ON p.product_id = oi.product_id
INNER JOIN orders o
ON oi.order_id = o.order_id
WHERE o.status <> 'cancelled'
GROUP BY MONTH(o.order_date), MONTHNAME(o.order_date), YEAR
ORDER BY YEAR, MONTH(o.order_date);

-- 5. Revenue by sales channel
-- identify which sales channels generate the highest revenue
SELECT o.channel, SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
INNER JOIN order_items oi
ON p.product_id = oi.product_id
INNER JOIN orders o
ON oi.order_id = o.order_id
WHERE o.status <> 'cancelled'
GROUP BY o.channel
ORDER BY revenue DESC;

-- 6. Total quantity sold by product category
-- calculate the total quantity of products sold in each category
SELECT p.category, SUM(oi.quantity) AS quantity
FROM products p
INNER JOIN order_items oi
ON p.product_id = oi.product_id
INNER JOIN orders o
ON oi.order_id = o.order_id
WHERE o.status <> 'cancelled'
GROUP BY p.category;

-- 7. Payment method analysis
-- count how many payments were made using each payment method
SELECT payment_method, COUNT(*)
FROM payments
GROUP BY payment_method;

-- 8. Payment status analysis
-- count payments by their status
SELECT payment_status, COUNT(*)
FROM payments
GROUP BY payment_status;

-- 9. Average payment amount
-- calculate the average recorded payment amount
SELECT ROUND(AVG(amount), 2)
FROM payments;

-- 10. Payment amount by payment method
-- calculate the total recorded payment amount for each payment method
SELECT payment_method, SUM(amount) AS total_payment_amount
FROM payments
GROUP BY payment_method;