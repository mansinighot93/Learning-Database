-- 1. Inner Join: Retrieve Orders with Their Items and Product Details
SELECT o.id AS order_id, o.order_date, p.name AS product_name, oi.quantity, p.price, (oi.quantity * p.price) AS total_price
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.item_id = p.id;

-- 2. Left Join: Retrieve All Products and Their Categories
SELECT p.id AS product_id, p.name AS product_name, c.name AS category_name
FROM products p
LEFT JOIN categories c ON p.category_id = c.id;

 -- 3.Right Join: Retrieve All Categories and Products in Each Category
SELECT c.id AS category_id, c.name AS category_name, p.name AS product_name
FROM categories c
RIGHT JOIN products p ON c.id = p.category_id;

-- 5. Self Join: Retrieve Products and Their Similar Products Based on Category
SELECT p1.id AS product_id, p1.name AS product_name, p2.name AS similar_product_name
FROM products p1
JOIN products p2 ON p1.category_id = p2.category_id AND p1.id <> p2.id;

-- 6. Join with Aggregation: Retrieve Total Sales Per Product
SELECT p.id AS product_id, p.name AS product_name, SUM(oi.quantity * p.price) AS total_sales
FROM products p
JOIN order_items oi ON p.id = oi.item_id
GROUP BY p.id, p.name;
