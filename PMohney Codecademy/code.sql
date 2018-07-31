PMohney 
FUNNELS


--1 What columns does the table have?

SELECT *
FROM survey
LIMIT 10;



--2  What is the number of responses for each question?

--This is not necessary for answer but used in powerpoint:

SELECT COUNT (DISTINCT user_id) AS 'Total Users'
FROM survey;


 SELECT question, COUNT(user_id) AS 'Responses'
 FROM survey
 GROUP BY question;





--4

 SELECT *
 FROM quiz
 LIMIT 5;
 
 SELECT *
 FROM home_try_on
 LIMIT 5;
 
 SELECT *
 FROM purchase
 LIMIT 5;



--5.
SELECT DISTINCT q.user_id,
CASE
            WHEN h.user_id IS NOT NULL THEN 'True'
            ELSE 'False'
END AS 'is_home_try_on',
  H.number_of_pairs,
CASE
              WHEN p.user_id IS NOT NULL THEN 'True'
            ELSE 'False'
END AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
    ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
    ON p.user_id = q.user_id
LIMIT 10;





--5.
SELECT DISTINCT q.user_id,
CASE
            WHEN h.user_id IS NOT NULL THEN 'True'
            ELSE 'False'
END AS 'is_home_try_on',
  H.number_of_pairs,
CASE
              WHEN p.user_id IS NOT NULL THEN 'True'
            ELSE 'False'
END AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
    ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
    ON p.user_id = q.user_id
LIMIT 10;


--6


--A B. We can compare conversion from quizhome_try_on and home_try_onpurchase.
WITH funnels AS (
  SELECT COUNT(DISTINCT q.user_id) AS 'Quiz',
        COUNT(DISTINCT hto.user_id) AS 'Home_Try_On',
    COUNT(DISTINCT p.user_id) AS 'Purchase'       FROM quiz AS 'q'
LEFT JOIN home_try_on as 'hto'
    ON q.user_id = hto.user_id
LEFT JOIN purchase AS 'p'
    ON q.user_id = p.user_id)
SELECT Quiz, Home_Try_On, Purchase,
          1.0 * Home_Try_ON / Quiz AS 'Quiz to Home Try On',
    1.0 * Purchase / Home_Try_On AS 'Home Try On to Purchase'  
FROM funnels;
 
--C. We can calculate the difference in purchase rates between customers who had 3 number_of_pairs with ones who had 5.
WITH funnels AS (
 SELECT DISTINCT
          hto.number_of_pairs AS 'number_of_pairs',
           p.user_id AS 'is_purchase'
     FROM home_try_on AS 'hto'
        LEFT JOIN purchase AS 'p'
       ON hto.user_id = p.user_id)
SELECT number_of_pairs,
COUNT(is_purchase) AS 'purchased'
FROM funnels
GROUP BY 1;


--D. The most common results of the style quiz.

SELECT style, COUNT(user_id)
FROM quiz
GROUP BY 1
ORDER BY 2 DESC;

SELECT fit, COUNT(user_id)
FROM quiz
GROUP BY 1
ORDER BY 2 DESC;

SELECT shape, COUNT(user_id)
FROM quiz
GROUP BY 1
ORDER BY 2 DESC;

SELECT color, COUNT(user_id)
FROM quiz
GROUP BY 1
ORDER BY 2 DESC;

--E. The most common types of purchase made.
SELECT COUNT(*) AS 'purchases', product_id, style, model_name, color, price
FROM purchase
GROUP BY 2
ORDER BY 1 DESC;


