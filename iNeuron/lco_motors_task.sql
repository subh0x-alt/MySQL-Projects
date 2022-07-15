-- TODO: lco_motors DATABASE MySQL Practice
-- The Current Mode is Set to Case insensitive.
SHOW DATABASES;

USE lco_motors;

-- TODO: Q1: How would you fetch details of the customers who cancelled orders?

SELECT customers.customer_id, customers.customer_name, customers.phone, customers.city, orders.order_id, orders.order_date, orders.status
FROM customers 
INNER JOIN orders ON customers.customer_id = orders.customer_id 
WHERE orders.status = 'Cancelled';

-- TODO: Q2: Fetch the details of customers who have done payments between the amount 5000 and 35000.

SELECT * FROM payments LIMIT 10;

SELECT customers.customer_id, customers.customer_name, payments.payment_date, payments.amount 
FROM payments
INNER JOIN customers ON payments.customer_id = customers.customer_id
WHERE amount BETWEEN 5000 AND 35000;

-- REVIEW: There is a Minor Problem with payments table: there are customers who have also made multiple payments.
-- TODO: FIXED

SELECT customers.customer_id, customers.customer_name, SUM(payments.amount) AS total_amount 
FROM payments
INNER JOIN customers ON payments.customer_id = customers.customer_id
WHERE payments.amount BETWEEN 5000 AND 35000
GROUP BY payments.customer_id;

-- TODO: Q3: Add new employee/salesman with follwing details:

INSERT INTO employees (employee_id, first_name, last_name, extension, email, office_code, reports_to, job_title)
VALUES(15657, "Lakshmi", "Roy", "x4065", "lakshmiroy1@lcomotors.com", "4", 1088, "Sales Rep");

-- TODO: Q4: Assign the new employee to the customer whose phone is 2125557413.

SELECT * FROM customers WHERE phone = '2125557413';
UPDATE customers SET sales_employee_id = 15657 WHERE phone = '2125557413';

-- TODO: Q5: Write a SQL query to fetch shipped motorcycles.
-- JOINS on 3 Tables***

SELECT orders.order_id, orders.status, payments.payment_date, SUM(payments.amount) AS total_amount 
FROM orders
((INNER JOIN products ON payments.customer_id = customers.customer_id)
INNER JOIN )
WHERE products.product_line = 'Motorcycles';

-- TODO: Q6: Write a SQL query to get details of all employees/salesmen in the office located in Sydney.

-- Using a JOIN statement between the two tables:

SELECT emp.* FROM
employees AS emp
INNER JOIN offices ON emp.office_code = offices.office_code
WHERE offices.city = 'Sydney';

-- Without using join statement:

SELECT * FROM employees WHERE office_code=6;

-- TODO: Q7: How would you fetch the details of customers whose orders are in process?

SELECT DISTINCT status FROM orders;
-- 'In Process'

SELECT c.*, o.order_date, o.order_id, o.status
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE LOWER(o.status) = 'in process';

-- TODO: Q8: How would you fetch the details of products with less than 30 orders?

SELECT products.product_code, products.product_name, CONCAT(SUBSTR(products.product_description, 1, 35), '...') AS Product_description, products.product_vendor, products.buy_price, products.mrp, orderdetails.each_price, orderdetails.order_id, orderdetails.quantity_ordered
FROM products INNER JOIN orderdetails
ON products.product_code = orderdetails.product_code
WHERE orderdetails.quantity_ordered < 30
GROUP BY orderdetails.product_code
ORDER BY orderdetails.quantity_ordered DESC;

-- TODO: Q9: It is noted that the payment (check number OM314933) was actually 2575. Update the record.

SELECT * FROM payments WHERE check_number = 'OM314933';
UPDATE payments SET amount = 2575 WHERE check_number = 'OM314933'

-- TODO: Q10: Fetch the details of salesmen/employees dealing with customers whose orders are resolved.

SELECT * FROM orders WHERE STATUS='Resolved';

SELECT DISTINCT EMP.employee_id, CONCAT(EMP.first_name, ' ', EMP.last_name) AS employee_name, EMP.email, EMP.job_title, CSTMR.customer_id, ODR.order_id, ODR.status
FROM employees AS EMP
LEFT JOIN customers AS CSTMR ON EMP.employee_id = CSTMR.sales_employee_id
RIGHT JOIN orders AS ODR ON CSTMR.customer_id = ODR.customer_id
WHERE LOWER(ODR.status )= 'resolved';

-- TODO: Q11: Get the details of the customer who made the maximum payment.
SELECT P.customer_id AS CustomerID, C.customer_name, C.first_name, C.last_name, C.phone, C.city, C.state, C.country, SUM(P.amount) AS Total_Amount 
FROM customers AS C
INNER JOIN payments AS P 
ON C.customer_id = P.customer_id
GROUP BY P.customer_id
ORDER BY amount DESC
LIMIT 1;

-- TODO: Q12: Fetch list of orders shipped to France.
SELECT * FROM customers WHERE country='FRANCE';
SELECT * FROM orders LIMIT 10; 

SELECT DISTINCT customers.customer_id, customers.customer_name, customers.city, customers.country, orders.order_id, orders.order_date, orders.shipped_date, orders.status
FROM customers
LEFT JOIN orders ON orders.customer_id = customers.customer_id
WHERE customers.country='FRANCE' AND orders.status='Shipped';

-- TODO: Q13: How many customers are from Finland who placed orders

-- To display the number of Customers from Finland.
SELECT DISTINCT COUNT(customers.customer_id) AS 'Total Customers from Finland'
FROM customers
LEFT JOIN orders ON orders.customer_id = customers.customer_id
WHERE customers.country='FINLAND';

-- To display the customers from Finland.
SELECT DISTINCT customers.customer_id, customers.customer_name, customers.city, customers.country, orders.order_id, orders.order_date, orders.status
FROM customers
LEFT JOIN orders ON orders.customer_id = customers.customer_id
WHERE customers.country='FINLAND';

-- TODO: Q14: Get the details of the customer and payments they made between May 2019 and June 2019.
-- REVIEW: Check if the datatype of the payment_date column is `date` (or) not.
DESCRIBE payments;

SELECT C.customer_id AS CustomerID, C.customer_name AS 'Customer Company Name', C.first_name, C.last_name, C.phone, C.city, C.state, C.country, P.payment_date, P.amount
FROM customers as C
INNER JOIN payments AS P
ON C.customer_id = P.customer_id
WHERE P.payment_date BETWEEN '2019-05-01' AND '2019-06-30';

-- TODO: Q15: How many orders shipped to Belgium in 2018?

SELECT C.customer_id AS CustomerID, C.customer_name AS 'Customer Company Name', C.first_name, C.last_name, C.city, C.country, O.order_date
FROM customers as C
INNER JOIN orders AS O
ON C.customer_id = O.customer_id
WHERE (O.order_date BETWEEN '2018-01-01' AND '2018-12-31') AND C.country = 'BELGIUM' AND O.status = 'Shipped';

-- TODO: Q16: Get the details of the salesman/employee with offices dealing with customers in Germany.

SELECT E.employee_id AS EMP_ID, CONCAT(E.first_name, ' ', E.last_name) AS Employee_Name, E.email, E.job_title, C.customer_name, C.country
FROM employees AS E
INNER JOIN customers AS C
ON E.employee_id = C.sales_employee_id
WHERE C.country = 'GERMANY';

-- TODO: Q17: The customer (id:496) made a new order today and the details are as follows:
-- Order id : 10426
-- Product Code: S12_3148
-- Quantity : 41
-- Each price : 151
-- Order line number : 11
-- Order date : <today’s date>
-- Required date: <10 days from today>
-- Status: In Process

INSERT INTO orders (order_id, order_date, required_date, status, customer_id)
VALUES(10426, CURRENT_DATE(), ADDDATE(CURRENT_DATE(), INTERVAL 10 DAY), 'In Process', '496');

INSERT INTO orderdetails (order_id, product_code, quantity_ordered, each_price, order_line_number)
VALUES(10426, 'S12_3148', 41, 151, 11);


-- TODO: Q18: Fetch details of employees who were reported for the payments made by the customers between June 2018 and July 2018.

SELECT E.employee_id, CONCAT(E.first_name , ' ', E.last_name) AS 'Employee Name', E.email, E.job_title AS 'Designation', C.customer_id, P.payment_date, P.amount
FROM employees as E
INNER JOIN customers as C
ON E.employee_id = C.sales_employee_id
INNER JOIN payments AS P
ON C.customer_id = P.customer_id
WHERE P.payment_date BETWEEN '2018-06-01' AND '2018-07-31';

-- TODO: Q19: A new payment was done by a customer(id: 119). Insert the below details.
-- Check Number : OM314944
-- Payment date : <today’s date>
-- Amount : 33789.55

INSERT INTO payments (customer_id, check_number, payment_date, amount)
VALUES(119, 'OM314944', CURRENT_DATE(), 33789.55);

-- TODO: Q20: Get the address of the office of the employees that reports to the employee whose id is 1102.

SELECT E.employee_id, CONCAT(E.first_name, ' ', E.last_name) AS Employee_name, E.job_title AS 'Designation', O.office_code AS 'Office Code', 
O.city AS 'City', CONCAT(O.address_line1, ', ', O.country, ', ' , O.city, ' - ', O.postal_code) AS 'Office Address', O.phone AS 'Office Contact No.'
FROM employees AS E
RIGHT JOIN offices AS O
ON E.office_code = O.office_code
WHERE E.employee_id=1102;

-- TODO: Q21: Get the details of the payments of classic cars.

SELECT P.check_number, P.payment_date, P.amount,
products.product_name, products.product_line , C.customer_id AS done_by 
FROM payments AS P
LEFT JOIN customers AS C
ON C.customer_id = P.customer_id 
RIGHT JOIN orders AS O
ON O.customer_id = C.customer_id 
LEFT JOIN orderdetails AS OD
ON OD.order_id = O.order_id 
LEFT JOIN products
ON products.product_code = OD.product_code 
WHERE products.product_line = "Classic Cars";

-- TODO: Q22: How many customers ordered from the USA?

SELECT COUNT( DISTINCT customers.customer_id) AS 'No. of customers who ordered from USA:'
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
WHERE customers.country = 'USA' ;

-- TODO: Q23: Get the comments regarding resolved orders.

SELECT order_id, order_date, status, comments 
FROM orders 
WHERE status = 'Resolved';

-- TODO: Q24: Fetch the details of employees/salesmen in the USA with office addresses.

SELECT DISTINCT E.employee_id, CONCAT(E.first_name, ' ', E.last_name) AS Employee_name, E.job_title AS 'Designation', O.office_code AS 'Office Code', 
O.city AS 'City', CONCAT(O.address_line1, ', ', O.country, ', ' , O.city, ' - ', O.postal_code) AS 'Office Address', O.phone AS 'Office Contact No.'
FROM employees AS E
RIGHT JOIN offices AS O
ON E.office_code = O.office_code
WHERE offices.country='USA';

-- TODO: Q25: Fetch total price of each order of motorcycles. (Hint: quantity x price for each record).

SELECT O.order_id, O.product_code, O.quantity_ordered, O.each_price, (O.quantity_ordered * O.each_price) AS 'Total Price:'
FROM orderdetails AS O
LEFT JOIN products AS P
ON O.product_code = P.product_code
WHERE P.product_line = 'Motorcycles';

-- TODO: Q26: Get the total worth of all planes ordered.

SELECT SUM(O.quantity_ordered * O.each_price) AS 'Total worth of Planes'
FROM orderdetails AS O
LEFT JOIN products AS P
ON O.product_code = P.product_code
WHERE P.product_line = 'Planes';

-- TODO: Q27: How many customers belong to France?

SELECT DISTINCT COUNT(customer_id) AS 'No. customers from France:'
FROM customers WHERE country = 'France';

-- TODO: Q28: Get the payments of customers living in France.

SELECT DISTINCT C.customer_id AS "Customer-ID", C.customer_name AS 'Company Name', CONCAT(C.first_name, " ", C.last_name) AS 'Incharge-Full Name', 
P.check_number, P.payment_date, P.amount,
C.city AS 'City', CONCAT(C.address_line1, ', ', C.country, ', ' , C.city, ' - ', C..postal_code) AS "Customer's Address", C.phone AS "Customer's Contact No."
FROM customers AS C
JOIN payments AS P
ON C.customer_id = P.customer_id
WHERE country = 'France';

-- TODO: Q29: Get the office address of the employees/salesmen who report to employee 1143.

SELECT DISTINCT E.employee_id, CONCAT(E.first_name, ' ', E.last_name) AS Employee_name, E.job_title AS 'Designation', E.reports_to AS 'Report', O.office_code AS 'Office Code', 
O.city AS 'City', CONCAT(O.address_line1, ', ', O.country, ', ' , O.city, ' - ', O.postal_code) AS 'Office Address', O.phone AS 'Office Contact No.'
FROM employees AS E
RIGHT JOIN offices AS O
ON E.office_code = O.office_code
WHERE E.reports_to=1143;
