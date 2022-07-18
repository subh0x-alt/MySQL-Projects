# Project-2: Instagram user Analytics Report.
## Project Description:
<p>In the given assignment, we must present a thorough report to Instagram's product team; the management need certain critical insights from the user schema that will be vital in driving increased user engagement for Instagram. Multiple teams will utilise the conclusions produced from the analysis for launch marketing campaigns, decide on new features for designing an app, measure the performance of the app by evaluating user engagement, and enhance the overall experience while also securing business growth.</p>
<p>The Instagram user Analytics project will focus on producing insights using SQL as the primary analytical tool. Loading the schema in the MySQL server takes the first priority.</p>

## ✍🏼 Approach:
### 1️⃣ [Creating a Database](https://github.com/Subhrajit91939/MySQL-Projects/edit/main/Trainity-SQL-DataAnalystProjects/Solution_Report.md#resources)<br>
```sql
-- Selecting the `ig_clone` database.
SHOW DATABASES;
USE ig_clone;
```
Verifying if all the tables have been created properly (or) not.

```sql
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
```

### 2️⃣ The marketing team wants to launch some campaigns, and they need help with determining the following:
#### Q1. Rewarding Most Loyal Users: People who have been using the platform for the longest time.
      *Task:* Find the 5 oldest users of the Instagram from the database provided.
We use the `users` table to retrieve the data as it contains the users id, username and their joining date which is required for sorting the table and retrieving the 
oldest users of Instagram from the database.
```sql
SELECT
        id AS 'User-ID',
        username AS 'Username',
        created_at AS 'Joined Instagram on'
        -- Selecting the id, username and the created_at columns with proper aliasing.
FROM users
ORDER BY created_at ASC 
-- Sorting the users with respect to the created_at column using the `ORDER BY` clause in the ascending order.
LIMIT 5; -- As we need only the First 5 users for instagram, we use the `LIMIT` clause
```
```sql
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
```
#### Q2. Remind Inactive Users to Start Posting: By sending them promotional emails to post their 1st photo.
     *Task:* Find the users who have never posted a single photo on Instagram.
     
```sql
SELECT 
        users.id AS 'User-ID',
        users.username AS 'Users'
FROM users
WHERE users.id NOT IN (SELECT photos.user_id FROM photos);
```
```sql
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
```
#### Q3. Declaring Contest Winner: The team started a contest and the user who gets the most likes on a single photo will win the contest now they wish to declare the winner.
     *Task:* Identify the winner of the contest and provide their details to the team.
```sql
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
```
```sql
mysql> source insta_task.sql
+---------+--------+---------------+--------------+
| PhotoId | UserId | Username      | No. of Likes |
+---------+--------+---------------+--------------+
|     145 |     52 | Zack_Kemmer93 |           48 |
+---------+--------+---------------+--------------+
1 row in set (0.01 sec)
```
#### Q4. Hashtag Researching: A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform.
     *Task:* Identify and suggest the top 5 most commonly used hashtags on the platform
     
```sql
SELECT 
        photo_tags.tag_id AS 'TagId', 
        tags.tag_name AS 'Tag', 
        COUNT(photo_tags.tag_id) AS 'No. of Occurences'
FROM photo_tags
JOIN tags ON tags.id = photo_tags.tag_id
GROUP BY photo_tags.tag_id
ORDER BY COUNT(photo_tags.tag_id) DESC
LIMIT 5;
```

```sql
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
```
#### Q5. Launch AD Campaign: The team wants to know, which day would be the best day to launch ADs.
     *Task:* What day of the week do most users register on? Provide insights on when to schedule an ad campaign.

```sql
SELECT 
        ELT(DAYOFWEEK(users.created_at), 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat') AS 'Day of Week',
        COUNT(DAYOFWEEK(users.created_at)) AS 'No. of Registrations'
FROM users
GROUP BY DAYOFWEEK(users.created_at)
ORDER BY COUNT(DAYOFWEEK(users.created_at)) DESC;
```

```sql
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
```


```sql
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
```

```sql
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
```

```sql
SELECT 
        users.id AS 'User ID',
        users.username AS '(Bot*) Username'
FROM users
JOIN likes ON likes.user_id = users.id
GROUP BY likes.user_id
HAVING COUNT(likes.user_id) = 257;

```

```sql
mysql> source insta_task.sql
+---------+--------------------+--------------------+
| User ID | (Bot*) Username    | Total No. of Likes |
+---------+--------------------+--------------------+
|       5 | Aniya_Hackett      |                257 |
|      14 | Jaclyn81           |                257 |
|      21 | Rocio33            |                257 |
|      24 | Maxwell.Halvorson  |                257 |
|      36 | Ollie_Ledner37     |                257 |
|      41 | Mckenna17          |                257 |
|      54 | Duane60            |                257 |
|      57 | Julien_Schmidt     |                257 |
|      66 | Mike.Auer39        |                257 |
|      71 | Nia_Haag           |                257 |
|      75 | Leslie67           |                257 |
|      76 | Janelle.Nikolaus81 |                257 |
|      91 | Bethany20          |                257 |
+---------+--------------------+--------------------+
13 rows in set (0.01 sec)

mysql> source insta_task.sql
+---------+--------------------+
| User ID | (Bot*) Username    |
+---------+--------------------+
|       5 | Aniya_Hackett      |
|      14 | Jaclyn81           |
|      21 | Rocio33            |
|      24 | Maxwell.Halvorson  |
|      36 | Ollie_Ledner37     |
|      41 | Mckenna17          |
|      54 | Duane60            |
|      57 | Julien_Schmidt     |
|      66 | Mike.Auer39        |
|      71 | Nia_Haag           |
|      75 | Leslie67           |
|      76 | Janelle.Nikolaus81 |
|      91 | Bethany20          |
+---------+--------------------+
13 rows in set (0.01 sec)
```

### ⚙️ Tech-Stack Used: MySQL; Code-Editor Used: VS Code
![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white)
![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)

## 📊📈 Insights:
Jot down the insights and the knowledge you gained while making the project. You need to write what you infer about the things. Make sure it's brief and up to the point only. For Eg. If you got a graph then what do you understand by the graph, what changes can you make or what can you derive from the graph.

## 🎯 Result:
Mention what have you achieved while making the project and how do you think it has helped you.

## 🗃️ Drive Links:
**Database:** [trainity_insta_analytics.sql](https://drive.google.com/file/d/1JwEPL15NfOepUSuV7HTINW7XEqpx0UzN/view?usp=sharing) <br>
**Project code:** [instagram_sql_analsis.pdf](https://drive.google.com/file/d/1B6KDkOkqxVYPnZhAnkqDH-Ksv7LpXx_y/view?usp=sharing) <br>
**Project code(RAW .sql file):** [insta_task.sql](https://drive.google.com/file/d/1xXbRiX4VBpCXaI5s_mS70yCqHWMSZCIU/view?usp=sharing)	<br>

## 📂 Resources:
[Instagram Project- SQL Instructions](https://docs.google.com/document/d/1-0L_ZE-RI22q8UV818BZCXL6mgKTetcbVR5PbzmAVS0/edit) <br>
[Commands for creating Database.docx](https://docs.google.com/document/d/1-WhNRX1iYJIz7e5l28DMPWgsPklpE_w6/edit)
