-- TODO: Select DISTINCT
SELECT DISTINCT stu_fname AS FirstName, email FROM students;

-- TODO: ORDER BY keyword for arranging.
-- Ascending order
SELECT DISTINCT stu_fname, login_count, course_count 
FROM students ORDER BY login_count ASC;

-- Descending order
SELECT DISTINCT stu_fname, login_count, course_count 
FROM students ORDER BY login_count DESC;

-- TODO: LIMIT Keyword for selecting specific number of records.

SELECT DISTINCT stu_fname, login_count
FROM students ORDER BY login_count DESC 
LIMIT 0, 5;

-- FIX: The rows start with an index of 0, whereas the strings start with an index of 1

SELECT DISTINCT stu_fname, login_count
FROM students ORDER BY login_count DESC 
LIMIT 3, 5;

-- TODO: LIKE Keyword
SELECT DISTINCT stu_fname, email FROM students
WHERE stu_fname LIKE '%esh';

-- TODO: LIKE Keyword
SELECT DISTINCT stu_fname, email FROM students
WHERE stu_fname LIKE 'm%';

-- TODO: COUNT Keyword
-- you might have guessed the difference between both the statements.
SELECT DISTINCT COUNT(stu_fname) FROM students;

SELECT COUNT( DISTINCT stu_fname) FROM students;

-- TODO: GROUP BY

DEFAULT MODE:SET @@sql_mode='';

SELECT stu_fname, signup_month, COUNT(*) FROM students
GROUP BY signup_month;

SELECT  stu_fname, email, login_count
FROM students
WHERE login_count = (
SELECT  MAX(login_count)
FROM students);


SELECT  stu_fname, email, login_count
FROM students
WHERE login_count = (
SELECT  MIN(login_count)
FROM students);

SELECT  stu_fname, email, course_count FROM students 
WHERE course_count=(SELECT MIN(course_count) FROM students);

SELECT  MIN(course_count)
FROM students;

SELECT MIN(login_count), signup_month FROM students
GROUP BY signup_month ORDER BY signup_month;

SELECT stu_fname, login_count, course_count FROM students
WHERE (login_count >= 20) AND (course_count >=5);

SELECT DISTINCT stu_fname, signup_month FROM students
WHERE ((signup_month = 7) OR (signup_month =10));

SELECT email, login_count, signup_month FROM students
WHERE signup_month BETWEEN 7 AND 10;
