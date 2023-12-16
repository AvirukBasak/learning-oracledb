-- 2. id and email of all customers who ordered more than 50000 in total
SELECT c.id, c.email
FROM customer c JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.email
HAVING SUM(order_price) > 50000;

-- 3. id and email of customer with highest total order amount
SELECT c.id, c.email, SUM(o.order_price) AS highest_total_order_amount
FROM customer c JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.email
HAVING SUM(o.order_price) = (
    SELECT MAX(total_order_amount) FROM (
        SELECT SUM(order_price) AS total_order_amount FROM orders GROUP BY customer_id
));

-- 3. alternative
SELECT customer_id, email, total_order_amount AS highest_total_order_amount
FROM (
    SELECT
        c.id AS customer_id,
        c.email as email,
        SUM(order_price) AS total_order_amount
    FROM customer c JOIN orders o ON c.id = o.customer_id
    GROUP BY c.id, c.email
)
ORDER BY highest_total_order_amount DESC
FETCH NEXT 1 ROWS ONLY;

-- 3. alternative
SELECT c.id, c.email, SUM(order_price) AS total_order_amount
FROM customer c JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.email
ORDER BY total_order_amount DESC
FETCH NEXT 1 ROWS ONLY;

-- 4. rider with the highest salary
SELECT *
FROM rider
WHERE salary = (SELECT MAX(salary) FROM rider);

-- 4.5. rider with second highest salary
SELECT *
FROM rider
WHERE salary < (SELECT MAX(salary) FROM rider)
ORDER BY salary DESC
FETCH NEXT 1 ROWS ONLY;

-- 4.5. alternative
SELECT *
FROM rider
ORDER BY salary DESC
OFFSET 1 ROW
FETCH NEXT 1 ROWS ONLY;

-- 4.5. alternative
SELECT *
FROM rider
WHERE salary = (
    SELECT MAX(salary) FROM rider WHERE salary < (  -- max of all the salaries i.e. less than the original max salary
        SELECT MAX(salary) FROM rider               -- the max salary
));

-- 5. salary of rider who delivered max no of times
SELECT r.id, r.email, r.salary, COUNT(*) AS no_of_deliveries
FROM rider r JOIN orders o ON r.id = o.rider_id
GROUP BY r.id, r.salary, r.id, r.email
ORDER BY no_of_deliveries DESC
FETCH NEXT 1 ROWS ONLY;

-- 5.9. find email of rider with most deliveries
WITH t AS (
    SELECT r.id, r.mobile, r.email, r.salary, COUNT(*) AS total_deliveries
    FROM rider r JOIN orders o ON r.id = o.rider_id
    GROUP BY r.id, r.mobile, r.email, r.salary
)
SELECT *
FROM t
WHERE total_deliveries = (SELECT MAX(total_deliveries) FROM t);

-- 6. total sales of month of August, year > 2000
SELECT SUM(order_price)
FROM orders
WHERE
    order_time LIKE '%-AUG-20%'
    AND
    order_time NOT LIKE '%-AUG-2000';

-- 7. total purchases made in July, year > 2010
SELECT COUNT(*)
FROM orders
WHERE order_time > '01-JAN-2010';

-- 8. to show number of orders delivered after the last order made by customer id 101
SELECT COUNT(*)
FROM orders
WHERE order_time > (
    SELECT MAX(order_time)
    FROM orders
    WHERE customer_id = 101
);
