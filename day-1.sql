-- database creation
CREATE DATABASE sql7challenge;

-- select database
USE sql7challenge;

-- create table customers
CREATE TABLE IF NOT EXISTS customers (
	customer_id INT PRIMARY KEY,
    full_name VARCHAR (100) NOT NULL,
    email VARCHAR (100) NOT NULL,
    city VARCHAR (50) NOT NULL,
    signup_date DATE NOT NULL,
    segment VARCHAR(20)
);

-- create table products
CREATE TABLE IF NOT EXISTS products (
	product_id INT PRIMARY KEY,
    product_name VARCHAR (100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL (10, 2) NOT NULL,
    cost DECIMAL (10, 2) NOT NULL
);

-- create table orders
CREATE TABLE IF NOT EXISTS orders (
	order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR (50) NOT NULL,
    channel VARCHAR (50) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

-- create table order_items
CREATE TABLE IF NOT EXISTS order_items (
	order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL (10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

-- create table payments
CREATE TABLE IF NOT EXISTS payments (
	payment_id INT PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    payment_method VARCHAR (100) NOT NULL,
    payment_status VARCHAR (100) NOT NULL,
    amount DECIMAL (10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

-- create table deliveries
CREATE TABLE IF NOT EXISTS deliveries (
	delivery_id INT PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    dispatch_date DATE NOT NULL,
    delivery_date DATE NULL,
    delivery_status VARCHAR (100) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);