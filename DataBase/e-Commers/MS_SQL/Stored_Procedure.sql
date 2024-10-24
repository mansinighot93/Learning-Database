USE tflecommerce;
-- 1. Creating a Stored Procedure for User Registration
CREATE PROCEDURE RegisterUser
    @p_username NVARCHAR(50),
    @p_password NVARCHAR(255),
    @p_email NVARCHAR(100),
    @p_address NVARCHAR(255)
AS
BEGIN
    INSERT INTO users (username, password, email, address)
    VALUES (@p_username, @p_password, @p_email, @p_address);
END

-- Execute Stored Procedure
EXEC RegisterUser @p_username='manasi',@p_password='mansi@123',@p_email='mansi@gmail.com',@p_address='Manchar';
SELECT * FROM users;

 -- 2. Creating a Stored Procedure for User Login
CREATE PROCEDURE LoginUser
    @p_username NVARCHAR(50),
    @p_password NVARCHAR(255)
AS
BEGIN
    SELECT id, username, email
    FROM users
    WHERE username = @p_username AND password = @p_password;
END;

-- Execute Stored Procedure
EXEC LoginUser @p_username='manasi',@p_password='mansi@123';

-- 3. Creating a Stored Procedure for Updating User Information
CREATE PROCEDURE UpdateUserInfo
    @p_user_id INT,
    @p_email VARCHAR(100),
    @p_address VARCHAR(255)
AS
BEGIN
    UPDATE users
    SET email = @p_email, address = @p_address
    WHERE id = @p_user_id;
END;

-- 4. Creating a Stored Procedure for Retrieving Order Details
DROP PROCEDURE IF EXISTS GetOrderDetails;

CREATE PROCEDURE GetOrderDetails
    @p_order_id INT
AS
BEGIN
    SELECT o.id AS order_id, o.order_date, o.shipping_address, o.total_amount,
           oi.item_id, p.name AS product_name, oi.quantity, p.price
    FROM orders o
    JOIN order_items oi ON o.id = oi.order_id
    JOIN products p ON oi.item_id = p.id
    WHERE o.id = @p_order_id;
END 

-- Execute Stored Procedure
EXEC GetOrderDetails @p_order_id = 2

-- 5. Creating a Stored Procedure for Low Stock Alerts
CREATE PROCEDURE LowStockAlert
    @p_threshold INT
AS
BEGIN
    SELECT id, name, stock
    FROM products
    WHERE stock < @p_threshold;
END;

-- Execute Stored Procedure
EXEC LowStockAlert @p_threshold = 100;

-- 6. Creating a Stored Procedure for Product Reviews
IF OBJECT_ID('AddProductReview', 'P') IS NOT NULL
    DROP PROCEDURE AddProductReview;
GO

CREATE PROCEDURE AddProductReview
    @p_product_id INT,
    @p_user_id INT,
    @p_rating INT,
    @p_review NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO reviews (product_id, user_id, rating, review_text)
    VALUES (@p_product_id, @p_user_id, @p_rating, @p_review);
END;

-- Execute Stored Procedure
EXEC AddProductReview @p_product_id = 1, @p_user_id = 2, @p_rating = 5, @p_review = 'Great product!';
SELECT * FROM reviews;

-- 7. Creating a Stored Procedure for Monthly Sales Aggregation
CREATE PROCEDURE MonthlySalesReport
    @p_year INT,
    @p_month INT
AS
BEGIN
    SELECT p.id AS product_id, p.name AS product_name,
           SUM(oi.quantity) AS total_quantity_sold,
           SUM(oi.quantity * p.price) AS total_sales
    FROM orders o
    JOIN order_items oi ON o.id = oi.order_id
    JOIN products p ON oi.item_id = p.id
    WHERE YEAR(o.order_date) = @p_year AND MONTH(o.order_date) = @p_month
    GROUP BY p.id, p.name;
END;

-- Execute Stored Procedure
EXEC MonthlySalesReport @p_year = 2024, @p_month = 8;
select * from products;

-- Create Stored Procedure for Apply Discount
CREATE PROCEDURE ApplyDiscount
    @p_order_id INT,
    @p_discount_code VARCHAR(50)
AS
BEGIN
    DECLARE @v_discount DECIMAL(5, 2);
    DECLARE @v_total DECIMAL(10, 2);
    -- Retrieve discount percentage from the discount_codes table
    SELECT @v_discount = discount_percentage
    FROM discount_codes
    WHERE code = @p_discount_code 
    AND GETDATE() BETWEEN start_date AND end_date;
    IF @v_discount IS NOT NULL
    BEGIN
        -- Get the current total amount of the order
        SELECT @v_total = total_amount
        FROM orders
        WHERE id = @p_order_id;
        -- Apply the discount
        SET @v_total = @v_total - (@v_total * (@v_discount / 100));
        -- Update the order with the discounted amount
        UPDATE orders
        SET total_amount = @v_total
        WHERE id = @p_order_id;
    END
    ELSE
    BEGIN
        -- Throw an error for invalid or expired discount code
        RAISERROR ('Invalid or expired discount code.', 16, 1);
    END
END

-- Execute Stored Procedured
EXEC ApplyDiscount @p_order_id='1' , @p_discount_code='DIWALI21';
SELECT * FROM orders;	
select * from discount_codes;