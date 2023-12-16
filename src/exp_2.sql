-- Add a column to rider for salary
ALTER TABLE rider
ADD salary NUMBER;

UPDATE rider
SET salary = ROUND(DBMS_RANDOM.VALUE(7000, 12000));

SELECT * FROM rider FETCH FIRST 5 ROWS ONLY;

-- Retrieve rows from 5 to 15 from the customer table using a subquery
SELECT *
FROM (
    SELECT t.*, ROWNUM rnum
    FROM customer t
    WHERE ROWNUM <= 15
)
WHERE rnum >= 5;

-- Retrieve rows from 5 to 15 from the customer table using a subquery
SELECT * FROM rider WHERE id >= 5 AND id <= 10;

-- Retrieve 15 random rows from the orders table
SELECT * FROM orders SAMPLE(15);

UPDATE rider
SET salary = salary + 5
WHERE salary < 10500;

-- raise salary by 25%
UPDATE rider
SET salary = salary * 1.25
WHERE salary >= 7000 AND salary <= 12000;

-- insert new column to order table for order price
ALTER TABLE orders
ADD order_price INT;

ALTER TABLE orders
MODIFY order_price NUMBER(10, 2);

ALTER TABLE orders
RENAME COLUMN price TO order_price;

UPDATE orders
SET order_price = ROUND(DBMS_RANDOM.VALUE(500, 3000));

DESC orders;

-- insert new order
INSERT INTO orders (id, customer_id, rider_id, order_price, order_time)
VALUES (101, 1, 1, 100, SYSDATE);

UPDATE orders
SET order_price = 113.44,
    order_time = SYSDATE
WHERE id = 101;

COMMIT;
