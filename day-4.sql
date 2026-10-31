USE sql7challenge;

-- 1. Total customers
-- count the total number of customers registered in the database
SELECT COUNT(customer_id)
FROM customers;

-- 2. Customers by city
-- Count the number of customers in each city to identify which cities have the most customers
SELECT city, COUNT(*) AS customers_count
FROM customers
GROUP BY city
ORDER BY customers_count DESC
LIMIT 5;

-- 3. Top 10 customers by order count
-- identify the top 10 customers who placed the highest number of non-cancelled orders.
SELECT c.customer_id, c.full_name, COUNT(*) AS total_orders
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.status <> 'cancelled'
GROUP BY c.customer_id, c.full_name
ORDER BY total_orders DESC
LIMIT 10;

-- 4. customer spending
-- calculate the total spending of each customer based on order item values, excluding cancelled orders.
SELECT o.order_id, c.full_name, SUM(oi.quantity * oi.unit_price) AS spending
FROM order_items oi
INNER JOIN orders o
ON oi.order_id = o.order_id
INNER JOIN customers c
ON o.customer_id = c.customer_id
WHERE o.status <> 'Cancelled'
GROUP BY o.order_id, c.full_name;

-- 5. Average spending per customer
-- calculate average spending per customer among customers who have placed at least one non-cancelled order.
SELECT c.customer_id, ROUND(SUM(oi.quantity * oi.unit_price)/COUNT(c.customer_id), 2) AS average_spending
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_id;

-- 6. Customers with more than 5 orders
-- find customers who have placed more than five non-cancelled orders
SELECT c.customer_id, c.full_name, COUNT(o.status)
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.status) > 5;

-- 7. Customer segment analysis
-- count the number of customers in each customer segment
SELECT segment, COUNT(*)
FROM customers
GROUP BY segment;

-- 8. Average orders per category
-- calculate the average number of non-cancelled orders per customer, including customers with zero qualifying orders

-- 9. Top 10 customers by spending
-- identify the top 10 customers who generated the highest item sales value from non-cancelled orders
SELECT c.customer_id, c.full_name, SUM(oi.quantity * oi.unit_price) AS spending
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_id, c.full_name
ORDER BY spending DESC
LIMIT 10;

-- 10. Customer signups by month
-- count the number of new customer registrations per month and display the results chronologically
SELECT YEAR(signup_date), MONTH(signup_date), COUNT(*)
FROM customers
GROUP BY YEAR(signup_date), MONTH(signup_date);