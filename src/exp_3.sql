SELECT COUNT(*) FROM customer;
SELECT COUNT(*) FROM rider;
SELECT COUNT(*) FROM orders;

SELECT * FROM customer SAMPLE(50);
SELECT * FROM rider SAMPLE(20);
SELECT * FROM orders SAMPLE(5);

-- display details of all customers whose sum of orders exceed Rs 5000
SELECT c.*, SUM(order_price) AS total_amount, COUNT(*) AS total_orders
FROM customer c JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.email, c.mobile, c.dob, c.location
HAVING SUM(order_price) > 5000;

-- display details of the all customers whose sum of orders price is either maximum or minimum
SELECT c.*, COUNT(*) AS total_orders, SUM(order_price) AS total_order_price
FROM customer c JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.email, c.mobile, c.dob, c.location
HAVING
    SUM(order_price) = (SELECT MAX(total_order_price) FROM (SELECT SUM(order_price) AS total_order_price FROM orders GROUP BY customer_id))
    OR
    SUM(order_price) = (SELECT MIN(total_order_price) FROM (SELECT SUM(order_price) AS total_order_price FROM orders GROUP BY customer_id))
ORDER BY total_order_price DESC;


-- list customers who have spent at least Rs 3000 on orders since 1st Jan 2010
SELECT                                                  -- 5. Project from the temporary table after grouping and group filtering;
    customer_id,                                        --    here aggregate functions run on each group rather than the whole teporary table.
    c.email,
    COUNT(*) AS total_orders,
    SUM(order_price) AS total_order_price
FROM customer c JOIN orders o ON c.id = o.customer_id   -- 1. Generate a temporary table with all possible combinations of rows from customer and orders tables
WHERE order_time >= '01-01-2010'                        -- 2. Filter out rows that do not satisfy the condition
GROUP BY customer_id, c.email                           -- 3. Run group by on the temporary table
HAVING SUM(order_price) >= 3000                         -- 4. Having is run on aggregated columns of each group to filter out groups that do not satisfy the condition
ORDER BY total_order_price DESC                         -- 6. Order by is run on the temporary table after grouping and group filtering to sort the result set
FETCH NEXT 20 ROW ONLY;                                 -- 7. Limit the number of rows in the result set

-- phrase to remember SQL execution order
-- FJWGHSOL: FROM, JOIN, WHERE, GROUP BY, HAVING, SELECT, ORDER BY, LIMIT
-- how it works:
-- 1. FROM and JOIN clauses are evaluated first, this produces a temporary table of all possible combinations of rows from the tables mentioned in the FROM and JOIN clauses
-- 2. WHERE clause is evaluated next, this filters out rows that do not satisfy the condition
-- 3. GROUP BY clause is evaluated next, this groups the rows into groups based on the values of the columns mentioned in the GROUP BY clause
-- 4. HAVING clause is evaluated next, this filters out groups that do not satisfy the condition
-- 5. SELECT clause is evaluated next, this produces the final result set
-- 6. ORDER BY clause is evaluated next, this sorts the result set based on the columns mentioned in the ORDER BY clause
-- 7. LIMIT clause is evaluated next, this limits the number of rows in the result set to the number mentioned in the LIMIT clause

SELECT SUM(order_price) FROM orders;
SELECT SUM(salary) FROM rider;

-- profit made from orders minus the salary paid to riders
SELECT tot_rev - tot_sal AS profit
FROM
    (SELECT SUM(order_price) AS tot_rev FROM orders),
    (SELECT SUM(salary) AS tot_sal FROM rider)
;
