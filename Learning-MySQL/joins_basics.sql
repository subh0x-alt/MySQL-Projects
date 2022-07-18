CREATE DATABASE new_lco;
USE new_lco;

CREATE TABLE users(
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30),
    email VARCHAR(30)
);

CREATE TABLE purchases(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount INT,
    users_id INT,
    FOREIGN KEY (users_id) REFERENCES users(id)
);

INSERT INTO users(username, email)
VALUES ('Thor', 'thor@gmail.com'),
('peter', 'peter@yahoo.com'),
('tony', 'star@starkind.com'),
('ben', 'ten@cn.com');

INSERT INTO purchases(order_date, amount, users_id)
VALUES ('2020-06-25', 299, 8);
