-- Section-3: iNeuron MySQL Course.
-- SHOW DATABASES;

-- TODO: Create a customer TABLE ot store all the customer DATA.
CREATE TABLE customers( customer_id INT NOT NULL AUTO_INCREMENT, customer_name VARCHAR(30) NOT NULL, email VARCHAR(40) NOT NULL DEFAULT 'No email provided.', amount_spent INT, PRIMARY KEY(customer_id) );
-- TODO: add some values in customers

INSERT INTO customer(customer_name, email, amount_spent) VALUES ( 'subhrajit', 'subhrajit@email.com', 20000 )

DROP TABLE customer;
INSERT INTO customers(customer_name , email , amount_spent) VALUES ('hitesh' , 'hitesh@lco.dev' , 35) , 
('George' , 'geo@lco.dev' , 45) , ('hitesh' , 'hitesh@lco.dev' , 88) , ('lina' , 'lina@gmail.com' , 78) , 
('jimmy' , 'jimmy@yahoo.co.in' , 54) , ('lina' , 'lina@yahoo.co.in' , 35) , ('hitesh' , 'hitesh@lco.dev' , 56);

-- TODO: can you give the names of all the customers?

SELECT customer_name FROM customers;

-- TODO: can you give the email of all the customers?
SELECT email FROM customers;

-- TODO: can you give the purchases of all the customers?
-- ALIASING KEYWORD: "AS"
SELECT amount_spent AS purchases FROM customers;

-- TODO: Update Jimmy's email id to jimmy'at'yahoo.com
-- TODO NOTE: Whenever performing an Update operation it is preffered to perform a Select operation.

SELECT * FROM customers WHERE customer_name = 'jimmy';
UPDATE customers SET email='jimmy@yahoo.com' WHERE customer_name = 'jimmy';

-- TODO: Lina's purchase amount needs to be changed to 38 from 35.

SELECT * FROM customers WHERE ((customer_name='lina') & (amount_spent=35));
UPDATE customers SET amount_spent=38 WHERE ((customer_name='lina') & (amount_spent=35));

-- TODO: Change all the email ids for Lina to lina'at'gmail.com

UPDATE customers
SET email = 'lina@gmail.com'
WHERE customer_name = 'lina';
