Create Database Customer_Shopping_Analysis;
use Customer_Shopping_Analysis;

CREATE TABLE customer (
    customer_id INT,
    age INT,
    gender VARCHAR(20),
    item_purchased VARCHAR(100),
    category VARCHAR(50),
    purchase_amount INT,
    location VARCHAR(100),
    size VARCHAR(10),
    color VARCHAR(50),
    season VARCHAR(20),
    review_rating DECIMAL(3,1),
    subscription_status VARCHAR(10),
    shipping_type VARCHAR(30),
    discount_applied VARCHAR(10),
    previous_purchases INT,
    payment_method VARCHAR(50),
    frequency_of_purchases VARCHAR(30),
    age_group VARCHAR(30),
    purchase_frequency_days INT
);


LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer_shopping_behavior_cleaned.csv'
INTO TABLE customer
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'secure_file_priv';	

Select * from customer;

SELECT
    category,
    ROUND(AVG(purchase_amount), 2) AS avg_purchase_amount
FROM customer
GROUP BY category
ORDER BY avg_purchase_amount DESC;

SELECT
    item_purchased,
    COUNT(*) AS purchase_count
FROM customer
GROUP BY item_purchased
ORDER BY purchase_count DESC
LIMIT 10;

SELECT
    gender,
    age_group,
    COUNT(*) AS total_orders,
    ROUND(AVG(purchase_amount), 2) AS avg_purchase_amount,
    SUM(purchase_amount) AS total_purchase_amount
FROM customer
GROUP BY gender, age_group
ORDER BY gender, age_group;

SELECT
    subscription_status,
    COUNT(*) AS total_orders,
    ROUND(AVG(purchase_amount), 2) AS avg_purchase_amount,
    ROUND(SUM(purchase_amount), 2) AS total_purchase_amount,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases
FROM customer
GROUP BY subscription_status
ORDER BY total_purchase_amount DESC;


SELECT
    discount_applied,
    COUNT(*) AS total_orders,
    ROUND(AVG(purchase_amount), 2) AS avg_purchase_amount,
    ROUND(SUM(purchase_amount), 2) AS total_purchase_amount
FROM customer
GROUP BY discount_applied
ORDER BY avg_purchase_amount DESC;

SELECT
    payment_method,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer),
        2
    ) AS percentage_of_orders
FROM customer
GROUP BY payment_method
ORDER BY total_orders DESC;

DESCRIBE customer;
