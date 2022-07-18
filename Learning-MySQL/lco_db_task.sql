-- TODO: TASK-1: CONCAT f_name and l_name:
-- TODO: DISPLAY all the student names

SELECT stu_fname, stu_lname FROM students;

SELECT CONCAT(stu_fname, ' ', stu_lname) AS student_name FROM students;

-- TODO: TASK-2: Give the full name and also display the login count of all the users.

SELECT  CONCAT(stu_fname, ' ' , stu_lname) AS student_fukkname, login_count
FROM students;

-- TODO: TASK-3: Give the users login and course count.

SELECT  CONCAT("User's login count: ", login_count, "; Course count: ", course_count) AS user_login_course_count
FROM students;

-- TODO: TASK-4: In the Stu_fname column Replace a with @
-- REPLACE: keyword is case sensitive
-- Example Syntax: SELECT REPLACE(column_name/string, letter_to_replace, replacement_letter)

SELECT REPLACE(stu_fname, 'a', '@') AS fname_rep FROM students;

-- TODO: get a list of all the emails, if email is longer than 7 characters then truncate with ...

SELECT CONCAT(SUBSTRING(email, 1, 7), '...') AS email_trunc FROM students;

-- REVERSE
SELECT REVERSE(stu_fname) FROM students;

-- TODO: Give the length of all the emails.
SELECT email, CHAR_LENGTH(email) AS email_length FROM students;

-- TODO: Get all the first names in uppercase & all the last names in lowercase.
-- Refer documentations for info related to any keywords/functions.
SELECT UPPER(stu_fname) AS fname_upper, LOWER(stu_lname) AS lname_lower FROM students;
