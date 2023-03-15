-- Consider all orders made between 01.01.22 and 31.12.2023

-- I have created 'users' table, because there can be people who did not anything ordered on previus year.  
-- DDL
CREATE TABLE users (
    user_id int PRIMARY KEY,
    full_name varchar(50) NOT NULL
);

CREATE TABLE orders(
    order_id int PRIMARY KEY,
    user_id int NOT NULL,
    date date NOT NULL,
    amount REAL NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE friends (
    user_id int PRIMARY KEY,
    subscription_start date NOT NULL,
    subscription_end date NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- DML
INSERT INTO users (user_id, full_name)
VALUES (1, 'Raiymbekov Daniyar'), (2, 'Ospanov Zhandos'), (3, 'Utegen Aruzhan'), (4, 'Zhamankhan Alikhan'),
       (5, 'Gani Arman'), (6, 'Alibekov Erlan'), (7, 'Imran Nur');


INSERT INTO orders (order_id, user_id, date, amount)
VALUES (1,1, '2021-10-02', 5000),
       (2,1, '2021-12-15', 4500),
       (3,1, '2022-01-02', 15000.99),
       (4,1, '2022-01-24', 15000.01),
       (5,1, '2022-02-12', 1500),
       (6,1, '2022-04-02', 25000),
       (7,1, '2022-06-21', 35680.9),
       (8,1, '2022-09-15', 1500),
       (9,1, '2022-10-07', 8715.87),
       (10,1, '2022-12-27', 42500.00);

INSERT INTO orders (order_id, user_id, date, amount)
VALUES (11,2, '2021-10-02', 5000),
       (12,2, '2022-01-07', 2500),
       (13,2, '2022-01-02', 15000.99),
       (14,2, '2022-02-04', 15000.01),
       (15,2, '2022-02-12', 1500),
       (16,2, '2022-03-15', 2500),
       (17,2, '2022-05-21', 15000),
       (18,2, '2022-09-22', 34200.1),
       (19,2, '2022-11-01', 2765.99),
       (20,2, '2022-12-27', 25560);


INSERT INTO orders (order_id, user_id, date, amount)
VALUES (21,3, '2023-02-02', 15000),
       (22,3, '2022-01-01', 23500.49),
       (23,3, '2022-02-02', 750),
       (24,3, '2022-02-04', 5700.01),
       (25,3, '2022-02-21', 2500),
       (26,3, '2022-04-15', 2500),
       (27,3, '2022-09-21', 15000),
       (28,3, '2022-09-22', 41009),
       (29,3, '2022-10-01', 15555),
       (30,3, '2022-11-27', 540);

INSERT INTO orders (order_id, user_id, date, amount)
VALUES (31,4, '2023-01-17', 25000),
       (32,4, '2022-01-01', 23500.49),
       (33,4, '2022-03-02', 1750),
       (34,4, '2022-03-04', 5000.01),
       (35,4, '2022-03-21', 2900),
       (36,4, '2022-06-15', 12500),
       (37,4, '2022-07-21', 17000),
       (38,4, '2022-08-22', 5900),
       (39,4, '2022-09-01', 200),
       (40,4, '2022-10-27', 24980.9);

INSERT INTO orders (order_id, user_id, date, amount)
VALUES (41,5, '2023-01-17', 52000),
       (42,5, '2022-02-01', 7666.6),
       (43,5, '2022-03-02', 980),
       (44,5, '2022-07-04', 6000),
       (45,5, '2022-07-21', 29000.9),
       (46,5, '2022-09-15', 34000),
       (47,5, '2022-09-21', 8600.5),
       (48,5, '2022-10-22', 59000),
       (49,5, '2022-10-01', 3420),
       (50,5, '2022-11-27', 6500);

INSERT INTO orders (order_id, user_id, date, amount)
VALUES (51,6, '2023-02-07', 12000),
       (52,6, '2022-01-01', 6909),
       (53,6, '2022-03-02', 9800),
       (54,6, '2022-05-04', 35500.9),
       (55,6, '2022-07-21', 2900),
       (56,6, '2022-09-15', 14700),
       (57,6, '2022-11-21', 33000.9),
       (58,6, '2022-11-22', 9900),
       (59,6, '2022-12-01', 22010.99),
       (60,6, '2022-12-27', 8600);


INSERT INTO orders (order_id, user_id, date, amount)
VALUES (61,7, '2023-01-07', 12000),
       (62,7, '2022-04-01', 6909),
       (63,7, '2022-05-02', 9800),
       (64,7, '2022-06-04', 35500.9),
       (65,7, '2022-07-21', 2900),
       (66,7, '2022-08-15', 14700),
       (67,7, '2022-09-21', 33000.9),
       (68,7, '2022-10-22', 9900),
       (69,7, '2022-11-01', 22010.99),
       (70,7, '2022-12-27', 8600);

INSERT INTO friends (user_id, subscription_start, subscription_end)
VALUES (4,'2022-06-01', '2022-12-31'), (5, '2021-01-01', '2022-05-31'), (6, '2021-01-01', '2023-12-31'), (7, '2020-01-01', '2024-12-31');


-- Created view 'Customers_2022' 
-- which suits the 'нет активной подписки friends в моменте или никогда не было' requirement
CREATE VIEW Customers_2022 AS
SELECT order_id, user_id, date, amount
FROM friends
    RIGHT JOIN orders USING (user_id)
WHERE ((subscription_start IS NULL AND subscription_end IS NULL) OR
       (date NOT BETWEEN subscription_start AND subscription_end)) AND
      date BETWEEN '2022-01-01' AND '2022-12-31';


-- The view 'Customers_2022' which groupped by their name and month of purchase
CREATE VIEW grouped_customers AS
SELECT full_name, DATE_PART('month', date) AS "M", sum(amount) AS "S"
   FROM Customers_2022
       INNER JOIN users USING (user_id)
   GROUP BY full_name,DATE_PART('month', date)
   ORDER BY full_name, "M";

CREATE TABLE month (
	month_id int PRIMARY KEY);
		
INSERT INTO month (month_id) VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12);
-- The view 'Customers_2022' which groupped by their name and month of purchase
-- + also, I added the month, when they did not made orders
CREATE VIEW grouped_customers_updated AS
SELECT q.full_name, q.month_id AS "Month", CASE WHEN "S" IS NOT null THEN "S" ELSE 0 END AS "Sum"
FROM grouped_customers 
	RIGHT JOIN 
(SELECT DISTINCT full_name, month_id
FROM grouped_customers, month
ORDER BY full_name, month_id) q ON q.full_name = grouped_customers.full_name AND q.month_id = grouped_customers."M";

-- to make report more understanable, i decided to implement crosstab(similar to Pivot Tables in Excel)
create extension tablefunc;
SELECT * FROM
crosstab(
	$$SELECT full_name, "Month", "Sum" FROM grouped_customers_updated$$) as Customer_Buy(full_name varchar(50), January real, February real, March real, April real, May real, June real, July real, August real, September real, October real, November real, December real);
