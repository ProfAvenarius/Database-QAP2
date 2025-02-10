-- Description: Inventory and orders system for an online retail store.
-- Author: DC Elliott
-- Date: Feb. 10, 2025

-- It will be assumed postgres has already been downloaded on your computer and the CLI client 
--  will be used to enter commands.

-- In your terminal enter:
--      psql postgres
-- to open the postgres session.

-- Step 1: Create the database. This database 'inventory_system' will be created
--  with user 'retail_manager' and password '123!Temp'. This allows these commands
--  to be created by any third party even those with default user/password stipulations 
--  or partitioning.

CREATE USER retail_manager WITH PASSWORD '123!Temp';
CREATE DATABASE inventory_system WITH OWNER retail_manager;

-- In your terminal enter: 
--      \c inventory_system
-- to connect to the new database.

-- Step 2: Create the Tables:

CREATE TABLE products (
    prod_id SERIAL PRIMARY KEY,
    prod_name TEXT NOT NULL,
    price DECIMAL(10,2),
    stock_quantity INT
);

CREATE TABLE customers (
    cust_id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    cust_id INT REFERENCES customers(cust_id),
    order_date DATE
);

CREATE TABLE order_items (
    order_id INT REFERENCES orders(order_id),
    prod_id INT REFERENCES products(prod_id),
    quantity INT,
    PRIMARY KEY (order_id, prod_id)
);

-- In your terminal enter: 
--      \dt
-- to confirm the new tables.

-- Step 3: Enter the data:

INSERT INTO products(prod_name, price, stock_quantity) VALUES
    ('Ball cap', 14.99, 25),
    ('T-shirt', 29.99, 40),
    ('Long sleeve shirt', 35.99, 30),
    ('Sweat pants', 39.99, 35),
    ('Shorts', 35.99, 20),
    ('Hoodie', 49.99, 35),
    ('Tuque', 12.99, 30),
    ('Socks', 9.99, 45);

INSERT INTO customers(first_name, last_name, email) VALUES
    ('Tony', 'Soprano', 'soprano99@sample.com'),
    ('Frank', 'Sinatra', 'fantastic@singer.com'),
    ('Elvis', 'Presley', 'grilledcheese@player.com'),
    ('Al', 'Greene', 'greatvoice@classic.com'),
    ('Walter', 'White', 'criminal@homeboy.com');

INSERT INTO orders(cust_id, order_date) VALUES 
    ((SELECT cust_id FROM customers WHERE first_name = 'Tony' AND last_name = 'Soprano'), '2025-01-15'),
    ((SELECT cust_id FROM customers WHERE first_name = 'Elvis' AND last_name = 'Presley'), '2025-01-05'),
    ((SELECT cust_id FROM customers WHERE first_name = 'Elvis' AND last_name = 'Presley'), '2025-01-25'),
    ((SELECT cust_id FROM customers WHERE first_name = 'Al' AND last_name = 'Greene'), '2024-11-25'),
    ((SELECT cust_id FROM customers WHERE first_name = 'Frank' AND last_name = 'Sinatra'), '2025-02-01'),
    ((SELECT cust_id FROM customers WHERE first_name = 'Walter' AND last_name = 'White'), '2025-01-07');



INSERT INTO order_items (order_id, prod_id, quantity) VALUES
    (1, (SELECT prod_id FROM products WHERE prod_name = 'T-shirt'), 2),
    (1, (SELECT prod_id FROM products WHERE prod_name = 'Sweat pants'), 1),
    (1, (SELECT prod_id FROM products WHERE prod_name = 'Long sleeve shirt'), 3),
    (2, (SELECT prod_id FROM products WHERE prod_name = 'T-shirt'), 3),
    (2, (SELECT prod_id FROM products WHERE prod_name = 'Ball cap'), 2),
    (2, (SELECT prod_id FROM products WHERE prod_name = 'Hoodie'), 1),
    (3, (SELECT prod_id FROM products WHERE prod_name = 'T-shirt'), 2),
    (3, (SELECT prod_id FROM products WHERE prod_name = 'Shorts'), 2),
    (4, (SELECT prod_id FROM products WHERE prod_name = 'Socks'), 5),
    (4, (SELECT prod_id FROM products WHERE prod_name = 'Ball cap'), 10),
    (4, (SELECT prod_id FROM products WHERE prod_name = 'Tuque'), 10),
    (5, (SELECT prod_id FROM products WHERE prod_name = 'T-shirt'), 4),
    (5, (SELECT prod_id FROM products WHERE prod_name = 'Long sleeve shirt'), 3),
    (6, (SELECT prod_id FROM products WHERE prod_name = 'T-shirt'), 5),
    (6, (SELECT prod_id FROM products WHERE prod_name = 'Hoodie'), 3),
    (6, (SELECT prod_id FROM products WHERE prod_name = 'Socks'), 10);


