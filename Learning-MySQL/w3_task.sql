-- TODO: get all the order_id, customer_name and date when order was placed.
SELECT * FROM customers LIMIT 2;
SELECT * FROM orders LIMIT 2;
SELECT * FROM order_details LIMIT 2;

-- TODO: We see that Customername can be obtained from the `customers` table; OrderID, Order Date from `orders` table.
-- TODO: Select columns from `customers` and `orders` tables using INNER JOIN.

SELECT orders.OrderID, customers.CustomerName, orders.OrderDate
FROM orders
INNER JOIN customers ON orders.CustomerID = customers.CustomerID
LIMIT 5;

-- TODO: Get the orderID, customer name and who is the shipper for that order.
-- TODO: shippers, orders, customers Table

SELECT orders.OrderID, customers.CustomerID, customers.CustomerName, shippers.ShipperName
FROM ((orders 
INNER JOIN customers ON orders.CustomerID = customers.CustomerID)
INNER JOIN shippers ON orders.ShipperID = shippers.ShipperID
) LIMIT 100;

-- FIXME: LEFT JOIN:
-- TODO: Get me all the customers name and their order ID

SELECT customers.CustomerID, customers.CustomerName, orders.OrderID
FROM customers
LEFT JOIN orders ON customers.CustomerID = orders.CustomerID
LIMIT 5;


-- FIXME: RIGHT JOIN:
-- TODO: Get me all the customers name and their order ID

SELECT customers.CustomerID, customers.CustomerName, orders.OrderID
FROM customers
RIGHT JOIN orders ON customers.CustomerID = orders.CustomerID
LIMIT 5;

-- TODO: UNION

SELECT City FROM customers
UNION
SELECT City FROM Suppliers ORDER BY City;
