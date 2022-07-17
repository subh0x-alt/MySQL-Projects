SHOW DATABASES;
USE dannys_diner;

SHOW TABLES;

-- +------------------------+
-- | Tables_in_dannys_diner |
-- +------------------------+
-- | members                |
-- | menu                   |
-- | sales                  |
-- +------------------------+
-- 3 rows in set (0.02 sec)

-- mysql> SELECT * FROM sales;
-- +-------------+----------------------------+------------+
-- | customer_id | order_date                 | product_id |
-- +-------------+----------------------------+------------+
-- | A           | 2021-01-01 00:00:00.000000 |          1 |
-- | A           | 2021-01-01 00:00:00.000000 |          2 |
-- | A           | 2021-01-07 00:00:00.000000 |          2 |
-- | A           | 2021-01-10 00:00:00.000000 |          3 |
-- | A           | 2021-01-11 00:00:00.000000 |          3 |
-- | A           | 2021-01-11 00:00:00.000000 |          3 |
-- | B           | 2021-01-01 00:00:00.000000 |          2 |
-- | B           | 2021-01-02 00:00:00.000000 |          2 |
-- | B           | 2021-01-04 00:00:00.000000 |          1 |
-- | B           | 2021-01-11 00:00:00.000000 |          1 |
-- | B           | 2021-01-16 00:00:00.000000 |          3 |
-- | B           | 2021-02-01 00:00:00.000000 |          3 |
-- | C           | 2021-01-01 00:00:00.000000 |          3 |
-- | C           | 2021-01-01 00:00:00.000000 |          3 |
-- | C           | 2021-01-07 00:00:00.000000 |          3 |
-- +-------------+----------------------------+------------+
-- 15 rows in set (0.00 sec)

-- mysql> SELECT * FROM menu;  
-- +------------+--------------+-------+
-- | product_id | product_name | price |
-- +------------+--------------+-------+
-- |          1 | sushi        |    10 |
-- |          2 | curry        |    15 |
-- |          3 | ramen        |    12 |
-- +------------+--------------+-------+
-- 3 rows in set (0.00 sec)

-- mysql> SELECT * FROM members; 
-- +-------------+----------------------------+
-- | customer_id | join_date                  |
-- +-------------+----------------------------+
-- | A           | 2021-01-07 00:00:00.000000 |
-- | B           | 2021-01-09 00:00:00.000000 |
-- +-------------+----------------------------+
-- 2 rows in set (0.00 sec)

-- REVIEW: Each of the following case study questions can be answered using a single SQL statement:

-- TODO: What is the total amount each customer spent at the restaurant?

SELECT 
        sales.customer_id AS 'Customer-ID', 
        sales.product_id AS 'Product-ID', 
        menu.product_name AS 'Food Ordered', 
        menu.price AS 'Price ($)'
FROM sales 
JOIN menu 
     ON sales.product_id = menu.product_id;

SELECT 
        sales.customer_id AS 'Customer-ID', 
        SUM(menu.price) AS 'Total Amount Spent ($)'
FROM sales 
JOIN menu 
     ON sales.product_id = menu.product_id
GROUP BY sales.customer_id;

-- +-------------+------------+--------------+-----------+
-- | Customer-ID | Product-ID | Food Ordered | Price ($) |
-- +-------------+------------+--------------+-----------+
-- | A           |          1 | sushi        |        10 |
-- | A           |          2 | curry        |        15 |
-- | A           |          2 | curry        |        15 |
-- | A           |          3 | ramen        |        12 |
-- | A           |          3 | ramen        |        12 |
-- | A           |          3 | ramen        |        12 |
-- | B           |          2 | curry        |        15 |
-- | B           |          2 | curry        |        15 |
-- | B           |          1 | sushi        |        10 |
-- | B           |          1 | sushi        |        10 |
-- | B           |          3 | ramen        |        12 |
-- | B           |          3 | ramen        |        12 |
-- | C           |          3 | ramen        |        12 |
-- | C           |          3 | ramen        |        12 |
-- | C           |          3 | ramen        |        12 |
-- +-------------+------------+--------------+-----------+
-- 15 rows in set (0.00 sec)

-- +-------------+------------------------+
-- | Customer-ID | Total Amount Spent ($) |
-- +-------------+------------------------+
-- | A           |                     76 |
-- | B           |                     74 |
-- | C           |                     36 |
-- +-------------+------------------------+
-- 3 rows in set (0.12 sec)

-- TODO: How many days has each customer visited the restaurant?

SELECT DISTINCT 
        customer_id, 
        DATE_FORMAT(order_date, GET_FORMAT(DATE, 'EUR')) AS 'Visit Date'
FROM sales;

SELECT 
        customer_id, 
        COUNT(DISTINCT order_date) AS 'No. of days Visited.'
FROM sales
GROUP BY customer_id;


-- +-------------+------------+
-- | customer_id | Visit Date |
-- +-------------+------------+
-- | A           | 01.01.2021 |
-- | A           | 07.01.2021 |
-- | A           | 10.01.2021 |
-- | A           | 11.01.2021 |
-- | B           | 01.01.2021 |
-- | B           | 02.01.2021 |
-- | B           | 04.01.2021 |
-- | B           | 11.01.2021 |
-- | B           | 16.01.2021 |
-- | B           | 01.02.2021 |
-- | C           | 01.01.2021 |
-- | C           | 07.01.2021 |
-- +-------------+------------+
-- 12 rows in set (0.00 sec)

-- +-------------+----------------------+
-- | customer_id | No. of days Visited. |
-- +-------------+----------------------+
-- | A           |                    4 |
-- | B           |                    6 |
-- | C           |                    2 |
-- +-------------+----------------------+
-- 3 rows in set (0.00 sec)

-- TODO: What was the first item from the menu purchased by each customer?

SELECT 
        sales.customer_id, 
        sales.product_id, 
        menu.product_name
FROM sales
JOIN menu 
     ON sales.product_id = menu.product_id
GROUP BY sales.customer_id
ORDER BY sales.order_date;

-- +-------------+------------+--------------+
-- | customer_id | product_id | product_name |
-- +-------------+------------+--------------+
-- | A           |          1 | sushi        |
-- | B           |          2 | curry        |
-- | C           |          3 | ramen        |
-- +-------------+------------+--------------+
-- 3 rows in set (0.00 sec)

-- TODO: What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT 
        menu.product_name 'Top Selling Product', 
        COUNT(sales.product_id) AS 'No. of Purchases'
FROM sales 
JOIN menu 
     ON sales.product_id = menu.product_id
GROUP BY sales.product_id
ORDER BY COUNT(sales.product_id) DESC 
LIMIT 1;


-- +---------------------+------------------+
-- | Top Selling Product | No. of Purchases |
-- +---------------------+------------------+
-- | ramen               |                8 |
-- +---------------------+------------------+
-- 1 row in set (0.00 sec)

-- TODO: Which item was the most popular for each customer?

-- FIXME: Hard-coded Approach
-- REVIEW:

(SELECT sales.customer_id, menu.product_name 'Product', COUNT(sales.product_id) AS 'No. of Purchases'
FROM sales JOIN menu ON sales.product_id = menu.product_id
WHERE customer_id = 'A'
GROUP BY sales.customer_id, sales.product_id
ORDER BY sales.customer_id ASC, COUNT(sales.product_id) DESC
LIMIT 1)
UNION
(SELECT sales.customer_id, menu.product_name 'Product', COUNT(sales.product_id) AS 'No. of Purchases'
FROM sales JOIN menu ON sales.product_id = menu.product_id
WHERE customer_id = 'B'
GROUP BY sales.customer_id, sales.product_id
ORDER BY sales.customer_id ASC, COUNT(sales.product_id) DESC)
UNION
(SELECT sales.customer_id, menu.product_name 'Product', COUNT(sales.product_id) AS 'No. of Purchases'
FROM sales JOIN menu ON sales.product_id = menu.product_id
WHERE customer_id = 'C'
GROUP BY sales.customer_id, sales.product_id
LIMIT 1);

-- TODO: Which item was purchased first by the customer after they became a member?
--  Assuming the customer became a member prior to purchasing a product the same day.

SELECT
        sales.customer_id AS 'Customer-ID', 
        menu.product_name AS 'First Purchase after Membership'
FROM sales 
JOIN menu 
    ON sales.product_id = menu.product_id
LEFT JOIN members
    ON sales.customer_id = members.customer_id
WHERE (sales.order_date >= members.join_date)
GROUP BY sales.customer_id
ORDER BY sales.customer_id ASC;

-- +-------------+---------------------------------+
-- | Customer-ID | First Purchase after Membership |
-- +-------------+---------------------------------+
-- | A           | curry                           |
-- | B           | sushi                           |
-- +-------------+---------------------------------+
-- 2 rows in set (0.00 sec)

-- TODO: Which item was purchased just before the customer became a member?



-- TODO: What is the total items and amount spent for each member before they became a member?

SELECT
        sales.customer_id AS 'Customer-ID', 
        SUM(menu.price) AS 'Total Amount Spent ($)'
FROM sales 
JOIN menu 
    ON sales.product_id = menu.product_id
LEFT JOIN members
    ON sales.customer_id = members.customer_id
WHERE (sales.order_date < members.join_date)
GROUP BY sales.customer_id
ORDER BY sales.customer_id ASC;

-- mysql> source dd_task.sql
-- +-------------+------------------------+
-- | Customer-ID | Total Amount Spent ($) |
-- +-------------+------------------------+
-- | A           |                     25 |
-- | B           |                     40 |
-- +-------------+------------------------+
-- 2 rows in set (0.00 sec)

-- REVIEW: Customer with ID `C` is not a member yet; As the problem statement requires data prior to becoming a member we can also include customer `C`

(SELECT
        sales.customer_id AS 'Customer-ID', 
        SUM(menu.price) AS 'Total Amount Spent ($)'
FROM sales 
JOIN menu 
    ON sales.product_id = menu.product_id
LEFT JOIN members
    ON sales.customer_id = members.customer_id
WHERE (sales.order_date < members.join_date)
GROUP BY sales.customer_id
ORDER BY sales.customer_id ASC)

UNION

(SELECT
        sales.customer_id AS 'Customer-ID', 
        SUM(menu.price) AS 'Total Amount Spent ($)'
FROM sales 
JOIN menu 
    ON sales.product_id = menu.product_id
LEFT JOIN members
    ON sales.customer_id = members.customer_id
WHERE sales.customer_id NOT IN (SELECT members.customer_id FROM members)
GROUP BY sales.customer_id
ORDER BY sales.customer_id ASC);

-- +-------------+------------------------+
-- | Customer-ID | Total Amount Spent ($) |
-- +-------------+------------------------+
-- | B           |                     40 |
-- | A           |                     25 |
-- | C           |                     36 |
-- +-------------+------------------------+
-- 3 rows in set (0.02 sec)


-- TODO: If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

SELECT 
        T.customer_id AS 'Customer-ID', 
        SUM(T.Points) AS 'Total Points'
FROM
    (SELECT 
            sales.customer_id,
        CASE
            WHEN menu.product_name = 'sushi' THEN menu.price*10*2
            ELSE menu.price*10
        END AS Points
    FROM sales
    JOIN menu ON sales.product_id = menu.product_id) AS T
GROUP BY T.customer_id;

-- +-------------+--------------+
-- | Customer-ID | Total Points |
-- +-------------+--------------+
-- | A           |          860 |
-- | B           |          940 |
-- | C           |          360 |
-- +-------------+--------------+
-- 3 rows in set (0.00 sec)

-- TODO: In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
