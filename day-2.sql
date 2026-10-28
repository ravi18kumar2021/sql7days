use sql7challenge;

-- 1. count the total number of orders
SELECT COUNT(*)
FROM orders;

-- 2. count how many orders exist for each status
SELECT status, COUNT(*)
FROM orders
GROUP BY status;

-- 3. Retrieve the 10 latest orders by order date
SELECT *
FROM orders
ORDER BY order_date ASC
LIMIT 10;

-- 4. Retrieve the 10 orders with highest total amount
SELECT orders.order_id, payments.amount
FROM orders
INNER JOIN payments
ON orders.order_id = payments.order_id
ORDER BY payments.amount DESC
LIMIT 10;

-- 5. count orders placed per day in chronological order
SELECT order_date, COUNT(*)
FROM orders
GROUP BY order_date
ORDER BY order_date ASC;

-- 6. group orders by month using date functions, identify peak and low-volume months
SELECT MONTH(order_date), COUNT(*)
FROM orders
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);

-- 7. calculate average order amount accross all orders, round result for clean reporting
SELECT ROUND(AVG(amount), 2)
FROM payments;

SELECT ROUND(AVG(order_amount), 2) AS average_order_amount
FROM (
	SELECT order_id, SUM(quantity * unit_price) AS order_amount
    FROM order_items
    GROUP BY order_id
) AS orders_total;

/* Insights
1. There are total 3000 orders placed.
2. Out of 3000, 1796 orders are delivered and 280 orders are returned whereas 236 orders are cancelled.
3. Daily orders counts are fluctuating and most orders in each day are delivered successfully.
4. In August month, 300 orders are placed whereas in November, only 130 orders are placed.
*/