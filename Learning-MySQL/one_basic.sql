SHOW DATABASES;
SELECT DATABASE();
USE photo_store;

CREATE TABLE cameras(
    model_name VARCHAR(30),
    quantity INT
);

DESC cameras;

-- TODO: Cameras table done.

DROP TABLE cameras;

CREATE TABLE canon_cameras(
    model_name VARCHAR(30),
    quantity INT
);

DESC canon_cameras;

-- TODO: Customer query tasks.

INSERT INTO canon_cameras(model_name,quantity)
-- Order of filling data is important.
VALUES("70-D", 12),
("80-D", 19),
("EOS-R", 25), 
("EOS-R5", 80), 
("EOS-R6", 50);

SELECT * FROM canon_cameras;
-- TASK: Customer Enters the store asks you to list all the camera models available.
SELECT model_name FROM canon_cameras;

-- TASK: Customer Enters the store asks :
-- How many 80-D can you give right now ?
SELECT model_name, quantity FROM canon_cameras 
WHERE (model_name = '80-d');

-- TASK: Customer Enters the store asks :
-- I want to buy 50 cameras of same model, what can you supply at his moment ?
SELECT model_name, quantity FROM canon_cameras 
WHERE (quantity >= 50);
