SHOW DATABASES;

CREATE DATABASE lco_users;
USE lco_users;

CREATE TABLE students(
    student_id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(60),
    stu_fname VARCHAR(60),
    stu_lname VARCHAR(60),
    login_count INT,
    course_count INT,
    signup_month INT,
    PRIMARY KEY (student_id)
);


INSERT INTO students(
    email,
    stu_fname,
    stu_lname,
    login_count,
    course_count,
    signup_month
)
VALUES
('yogeshk@gmail.com', 'Yogesh', 'kumar', 23, 5, 7),
('anshus@yahoo.com', 'Anusha', 'Sharma', 8, 2, 3),
('suryare@gmail.com', 'Surya', 'Reddy', 28, 5, 8),
('ravis@gmail.com', 'Ravi', 'Sharma', 15, 7, 4),
('aReasllyLongLikeReallyLongEmail@gmail.com', 'tom', 'broody', 15, 7, 4),
('akki@gmail.com', 'akki', 'sawarup', 35, 8, 1),
('gurk@gmail.com', 'gur', 'karan', 18, 3, 9),
('keertib@gmail.com', 'keerti', 'balan', 38, 13, 12),
('piyushc@gmail.com', 'piyush', 'chauhan', 9, 3, 7),
('satishk@gmail.com', 'satish', 'karnati', 39, 13, 9),
('dineshs@gmail.com', 'dinesh', 'sharma', 9, 1, 12),
('mukeshv@gmail.com', 'mukesh', 'verma', 17, 4, 11),
('mukeshv@gmail.com', 'mukesh', 'verma', 17, 4, 11),
('hemants@yahoo.com', 'hemant', 'singh', 37, 14, 10),
('hemants@yahoo.com', 'hemant', 'singh', 37, 14, 10),
('priyala@gmail.com', 'priyal', 'aryan', 19, 5, 9),
('snigdha@yahoo.com', 'Snigdha', 'Prasad', 19, 5, 9),
('mikeg@yahoo.com', 'Mike', 'george', 39, 15, 4),
('manon@gmail.com', 'manon', 'lea', 19, 5, 9),
('pauline@gmail.com', 'pauline', 'lucas', 19, 5, 9);