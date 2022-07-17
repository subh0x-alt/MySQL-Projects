CREATE DATABASE dannys_diner;
USE dannys_diner;

CREATE TABLE sales (
  customer_id VARCHAR(1),
  order_date DATETIME(6),
  product_id INT
);

INSERT INTO sales
  (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01 00:00:00.000000', 1),
  ('A', '2021-01-01 00:00:00.000000', 2),
  ('A', '2021-01-07 00:00:00.000000', 2),
  ('A', '2021-01-10 00:00:00.000000', 3),
  ('A', '2021-01-11 00:00:00.000000', 3),
  ('A', '2021-01-11 00:00:00.000000', 3),
  ('B',' 2021-01-01 00:00:00.000000', 2),
  ('B', '2021-01-02 00:00:00.000000', 2),
  ('B', '2021-01-04 00:00:00.000000', 1),
  ('B', '2021-01-11 00:00:00.000000', 1),
  ('B', '2021-01-16 00:00:00.000000', 3),
  ('B', '2021-02-01 00:00:00.000000', 3),
  ('C',' 2021-01-01 00:00:00.000000', 3),
  ('C', '2021-01-01 00:00:00.000000', 3),
  ('C', '2021-01-07 00:00:00.000000', 3);
 

CREATE TABLE menu (
  product_id INT,
  product_name VARCHAR(5),
  price INT
);

INSERT INTO menu
  (product_id, product_name, price)
VALUES
  (1, 'sushi', 10),
  (2, 'curry', 15),
  (3, 'ramen', 12);
  

CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATETIME(6)
);

INSERT INTO members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07 00:00:00.000000'),
  ('B', '2021-01-09 00:00:00.000000');