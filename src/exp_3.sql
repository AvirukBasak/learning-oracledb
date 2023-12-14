SELECT COUNT(*) FROM customer;
SELECT COUNT(*) FROM rider;
SELECT COUNT(*) FROM orders;

SELECT * FROM customer SAMPLE(50);
SELECT * FROM rider SAMPLE(20);
SELECT * FROM orders SAMPLE(5);

-- display details of all customers whose sum of orders exceed Rs 5000
SELECT c.*, SUM(o.order_price) AS total_amount
FROM customer c, orders o
WHERE c.id = o.customer_id
GROUP BY c.id, c.email, c.mobile, c.dob, c.location
HAVING SUM(o.order_price) > 5000;

-- display details of the all customers whose sum of orders price is either maximum or minimum
SELECT c.*, SUM(o.order_price) AS total_amount
FROM customer c, orders o
WHERE c.id = o.customer_id
GROUP BY c.id, c.email, c.mobile, c.dob, c.location
HAVING SUM(o.order_price) = (SELECT MAX(total_amount) FROM (SELECT SUM(order_price) AS total_amount FROM orders GROUP BY customer_id))
OR SUM(o.order_price) = (SELECT MIN(total_amount) FROM (SELECT SUM(order_price) AS total_amount FROM orders GROUP BY customer_id));

-- list customers who have spent at least Rs 1000 on orders since 1st Jan 1995
SELECT c.id AS customer_id, c.email AS customer_email, COUNT(o.id) AS total_orders, SUM(o.order_price) AS total_amount
FROM customer c JOIN orders o
ON c.id = o.customer_id
WHERE o.order_time >= '01-JAN-1995'
GROUP BY c.id, c.email
HAVING SUM(order_price) >= 3000
ORDER BY total_amount DESC
FETCH NEXT 10 ROW ONLY;

SELECT SUM(order_price) FROM orders;
SELECT SUM(salary) FROM rider;

-- profit made from orders minus the salary paid to riders
SELECT tot_rev - tot_sal AS profit
FROM
    (SELECT SUM(order_price) AS tot_rev FROM orders),
    (SELECT SUM(salary) AS tot_sal FROM rider)
;

