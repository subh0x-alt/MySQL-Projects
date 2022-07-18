SHOW DATABASES;
USE ig_clone;

/*
mysql> SHOW TABLES; 
+--------------------+
| Tables_in_ig_clone |
+--------------------+
| comments           |
| follows            |
| likes              |
| photo_tags         |
| photos             |
| tags               |
| users              |
+--------------------+
7 rows in set (0.02 sec)
*/

/*
A) Marketing: The marketing team wants to launch some campaigns, and they need your help with the following:
*/

-- Rewarding Most Loyal Users: People who have been using the platform for the longest time.
-- TODO: Your Task: Find the 5 oldest users of the Instagram from the database provided.

SELECT
        id AS 'User-ID',
        username AS 'Username',
        created_at AS 'Joined Instagram on'
FROM users
ORDER BY created_at ASC
LIMIT 5;

/* 
mysql> source insta_task.sql
+---------+------------------+---------------------+
| User-ID | Username         | Joined Instagram on |
+---------+------------------+---------------------+
|      80 | Darby_Herzog     | 2016-05-06 00:14:21 |
|      67 | Emilio_Bernier52 | 2016-05-06 13:04:30 |
|      63 | Elenor88         | 2016-05-08 01:30:41 |
|      95 | Nicole71         | 2016-05-09 17:30:22 |
|      38 | Jordyn.Jacobson2 | 2016-05-14 07:56:26 |
+---------+------------------+---------------------+
5 rows in set (0.00 sec)
*/

-- Remind Inactive Users to Start Posting: By sending them promotional emails to post their 1st photo.
-- TODO: Your Task: Find the users who have never posted a single photo on Instagram.

SELECT 
        users.id AS 'User-ID',
        users.username AS 'Users'
FROM users
WHERE users.id NOT IN (SELECT photos.user_id FROM photos);

/*
mysql> source insta_task.sql
+---------+---------------------+
| User-ID | Users               |
+---------+---------------------+
|       5 | Aniya_Hackett       |
|       7 | Kasandra_Homenick   |
|      14 | Jaclyn81            |
|      21 | Rocio33             |
|      24 | Maxwell.Halvorson   |
|      25 | Tierra.Trantow      |
|      34 | Pearl7              |
|      36 | Ollie_Ledner37      |
|      41 | Mckenna17           |
|      45 | David.Osinski47     |
|      49 | Morgan.Kassulke     |
|      53 | Linnea59            |
|      54 | Duane60             |
|      57 | Julien_Schmidt      |
|      66 | Mike.Auer39         |
|      68 | Franco_Keebler64    |
|      71 | Nia_Haag            |
|      74 | Hulda.Macejkovic    |
|      75 | Leslie67            |
|      76 | Janelle.Nikolaus81  |
|      80 | Darby_Herzog        |
|      81 | Esther.Zulauf61     |
|      83 | Bartholome.Bernhard |
|      89 | Jessyca_West        |
|      90 | Esmeralda.Mraz57    |
|      91 | Bethany20           |
+---------+---------------------+
26 rows in set (0.00 sec)
*/

-- Review :We need to send out a reminder to a total of 26 users for their first post on instagram.


-- Declaring Contest Winner: The team started a contest and the user who gets the most likes on a single photo will win the contest now they wish to declare the winner.
-- TODO: Your Task: Identify the winner of the contest and provide their details to the team

SELECT  
        likes.photo_id AS 'PhotoId',
        photos.user_id AS 'UserId',
        users.username AS 'Username',
        COUNT(likes.photo_id) AS 'No. of Likes'
FROM likes
JOIN photos ON likes.photo_id = photos.id
JOIN users ON photos.user_id = users.id
GROUP BY likes.photo_id
ORDER BY COUNT(likes.photo_id) DESC
LIMIT 1;

/*
mysql> source insta_task.sql
+---------+--------+---------------+--------------+
| PhotoId | UserId | Username      | No. of Likes |
+---------+--------+---------------+--------------+
|     145 |     52 | Zack_Kemmer93 |           48 |
+---------+--------+---------------+--------------+
1 row in set (0.01 sec)
*/

-- Hashtag Researching: A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform.
-- TODO: Your Task: Identify and suggest the top 5 most commonly used hashtags on the platform

SELECT 
        photo_tags.tag_id AS 'TagId', 
        tags.tag_name AS 'Tag', 
        COUNT(photo_tags.tag_id) AS 'No. of Occurences'
FROM photo_tags
JOIN tags ON tags.id = photo_tags.tag_id
GROUP BY photo_tags.tag_id
ORDER BY COUNT(photo_tags.tag_id) DESC
LIMIT 5;

/*
mysql> source insta_task.sql
+-------+---------+-------------------+
| TagId | Tag     | No. of Occurences |
+-------+---------+-------------------+
|    21 | smile   |                59 |
|    20 | beach   |                42 |
|    17 | party   |                39 |
|    13 | fun     |                38 |
|    18 | concert |                24 |
+-------+---------+-------------------+
5 rows in set (0.00 sec)
*/

-- REVIEW: The top 5 most used tags on instagram are: smile, beach, party, fun, concert.

-- Launch AD Campaign: The team wants to know, which day would be the best day to launch ADs.
-- TODO: Your Task: What day of the week do most users register on? Provide insights on when to schedule an ad campaign

SELECT 
        ELT(DAYOFWEEK(users.created_at), 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat') AS 'Day of Week',
        COUNT(DAYOFWEEK(users.created_at)) AS 'No. of Registrations'
FROM users
GROUP BY DAYOFWEEK(users.created_at)
ORDER BY COUNT(DAYOFWEEK(users.created_at)) DESC;

/*
mysql> source insta_task.sql
+-------------+----------------------+
| Day of Week | No. of Registrations |
+-------------+----------------------+
| Thu         |                   16 |
| Sun         |                   16 |
| Fri         |                   15 |
| Tue         |                   14 |
| Mon         |                   14 |
| Wed         |                   13 |
| Sat         |                   12 |
+-------------+----------------------+
7 rows in set (0.02 sec)
*/

--  REVIEW: As we can infer from the above output table that Thursdays and Sundays have the maximum no. of registrations followed by Friday.
-- We can use Ad campaign to Target/acquire users on instagram on thursdays and sundays and during the weekends despite lower registrations on saturdays.
-- As most users tend to register during the weekends i.e. Friday, Saturday, Sunday. (nearly 43% user registrations over the weekend) and 59% if we include thursday as well.

/*
B) Investor Metrics: Our investors want to know if Instagram is performing well and is not becoming redundant like Facebook, they want to assess the app on the following grounds:
*/

-- User Engagement: Are users still as active and post on Instagram or they are making fewer posts
-- TODO: Your Task: Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users.

-- Users that posted the highest number of photos
SELECT 
    COUNT(photos.id), 
    photos.user_id 
FROM photos 
GROUP BY photos.user_id 
ORDER BY COUNT(photos.id) DESC 
LIMIT 10;

-- Total number of photos posted on Instagram/Total no. of users that posted photos on Instagram
SELECT 
        ROUND(((SELECT COUNT(*) FROM photos)/(SELECT COUNT(DISTINCT user_id) FROM photos)), 2) AS '((Total number of photos posted /Total no. of DISTINCT users that posted photos) on Instagram';

-- Total No. of Photos on Instagram/Total number of users.
SELECT 
        ROUND(((SELECT COUNT(*) FROM photos)/(SELECT COUNT(*) FROM users)), 2) AS '(Total No. of Photos /Total No. of Users) on Instagram';

/*
mysql> source insta_task.sql
+------------------+---------+
| COUNT(photos.id) | user_id |
+------------------+---------+
|               12 |      23 |
|               11 |      88 |
|               10 |      59 |
|                9 |      86 |
|                8 |      29 |
|                8 |      58 |
|                6 |      77 |
|                5 |      47 |
|                5 |      43 |
|                5 |      33 |
+------------------+---------+
10 rows in set (0.00 sec)

+-----------------------------------------------------------------------------------------------+
| ((Total number of photos posted /Total no. of DISTINCT users that posted photos) on Instagram |
+-----------------------------------------------------------------------------------------------+
|                                                                                          3.47 |
+-----------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

+--------------------------------------------------------+
| (Total No. of Photos /Total No. of Users) on Instagram |
+--------------------------------------------------------+
|                                                   2.57 |
+--------------------------------------------------------+
1 row in set (0.01 sec)
*/

-- Bots & Fake Accounts: The investors want to know if the platform is crowded with fake and dummy accounts
-- TODO: Your Task: Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).

SELECT 
        users.id AS 'User ID',
        users.username AS '(Bot*) Username'
FROM users
JOIN likes ON likes.user_id = users.id
GROUP BY likes.user_id
HAVING COUNT(likes.user_id) = 257;

--  There are a total of 13 users (bots*) who have liked every single post on the site.

-- mysql> source insta_task.sql
-- +---------+--------------------+--------------------+
-- | User ID | (Bot*) Username    | Total No. of Likes |
-- +---------+--------------------+--------------------+
-- |       5 | Aniya_Hackett      |                257 |
-- |      14 | Jaclyn81           |                257 |
-- |      21 | Rocio33            |                257 |
-- |      24 | Maxwell.Halvorson  |                257 |
-- |      36 | Ollie_Ledner37     |                257 |
-- |      41 | Mckenna17          |                257 |
-- |      54 | Duane60            |                257 |
-- |      57 | Julien_Schmidt     |                257 |
-- |      66 | Mike.Auer39        |                257 |
-- |      71 | Nia_Haag           |                257 |
-- |      75 | Leslie67           |                257 |
-- |      76 | Janelle.Nikolaus81 |                257 |
-- |      91 | Bethany20          |                257 |
-- +---------+--------------------+--------------------+
-- 13 rows in set (0.01 sec)

-- mysql> source insta_task.sql
-- +---------+--------------------+
-- | User ID | (Bot*) Username    |
-- +---------+--------------------+
-- |       5 | Aniya_Hackett      |
-- |      14 | Jaclyn81           |
-- |      21 | Rocio33            |
-- |      24 | Maxwell.Halvorson  |
-- |      36 | Ollie_Ledner37     |
-- |      41 | Mckenna17          |
-- |      54 | Duane60            |
-- |      57 | Julien_Schmidt     |
-- |      66 | Mike.Auer39        |
-- |      71 | Nia_Haag           |
-- |      75 | Leslie67           |
-- |      76 | Janelle.Nikolaus81 |
-- |      91 | Bethany20          |
-- +---------+--------------------+
-- 13 rows in set (0.01 sec)