-- This worksheet inserts and sets up customer, rider and order data

SELECT * FROM nls_session_parameters WHERE parameter = 'NLS_DATE_FORMAT';
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

-- Create Customer Table
CREATE TABLE customer (
    id NUMBER PRIMARY KEY,
    email VARCHAR2(255),
    mobile VARCHAR2(20) NOT NULL,
    dob DATE,
    location VARCHAR2(255) NOT NULL
);

-- Create Rider Table
CREATE TABLE rider (
    id NUMBER PRIMARY KEY,
    email VARCHAR2(255),
    mobile VARCHAR2(20) NOT NULL,
    dob DATE,
    location VARCHAR2(255) NOT NULL
);

-- Create Orders Table
CREATE TABLE orders (
    id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    rider_id NUMBER,
    order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (rider_id) REFERENCES rider(id)
);

DESC customer;
DESC rider;
DESC orders;

-- Insert 10 dummy records into the customer table
-- INSERT ALL
--     INTO customer (id, email, mobile, dob, location) VALUES (1, 'customer1@example.com', '1234567890', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Location1')
--     INTO customer (id, email, mobile, dob, location) VALUES (2, 'customer2@example.com', '2345678901', TO_DATE('1985-02-15', 'YYYY-MM-DD'), 'Location2')
--     INTO customer (id, email, mobile, dob, location) VALUES (3, 'customer3@example.com', '3456789012', TO_DATE('1992-04-30', 'YYYY-MM-DD'), 'Location3')
--     INTO customer (id, email, mobile, dob, location) VALUES (4, 'customer4@example.com', '4567890123', TO_DATE('1988-06-22', 'YYYY-MM-DD'), 'Location4')
--     INTO customer (id, email, mobile, dob, location) VALUES (5, 'customer5@example.com', '5678901234', TO_DATE('1995-08-10', 'YYYY-MM-DD'), 'Location5')
--     INTO customer (id, email, mobile, dob, location) VALUES (6, 'customer6@example.com', '6789012345', TO_DATE('1991-10-05', 'YYYY-MM-DD'), 'Location6')
--     INTO customer (id, email, mobile, dob, location) VALUES (7, 'customer7@example.com', '7890123456', TO_DATE('1987-12-18', 'YYYY-MM-DD'), 'Location7')
--     INTO customer (id, email, mobile, dob, location) VALUES (8, 'customer8@example.com', '8901234567', TO_DATE('1994-03-25', 'YYYY-MM-DD'), 'Location8')
--     INTO customer (id, email, mobile, dob, location) VALUES (9, 'customer9@example.com', '9012345678', TO_DATE('1989-07-14', 'YYYY-MM-DD'), 'Location9')
--     INTO customer (id, email, mobile, dob, location) VALUES (10, 'customer10@example.com', '0123456789', TO_DATE('1993-09-03', 'YYYY-MM-DD'), 'Location10')
-- SELECT 1 FROM Dual;

-- insert 200 dummy records into the customer table
TRUNCATE TABLE customer;

INSERT INTO customer (id, email, mobile, dob, location)
SELECT 
    rownum + 10,
    'customer' || (rownum + 10) || '@example.com',
    DBMS_RANDOM.STRING('N', 10),
    TO_DATE('1991-01-01', 'YYYY-MM-DD') + DBMS_RANDOM.VALUE(0, 11688),
    'Location ' || (rownum + 10)
FROM dual
CONNECT BY level <= 200;

-- Insert 300 dummy records into the rider table
TRUNCATE TABLE rider;

INSERT INTO rider (id, email, mobile, dob, location)
SELECT 
    rownum,
    'rider' || rownum || '@example.com',
    DBMS_RANDOM.STRING('N', 10),
    TO_DATE('1991-01-01', 'YYYY-MM-DD') + DBMS_RANDOM.VALUE(0, 11688),
    'Location ' || rownum
FROM dual
CONNECT BY level <= 300;

-- Insert 100000 orders with random customer and rider IDs
TRUNCATE TABLE orders;

INSERT INTO orders (id, customer_id, rider_id, order_time)
SELECT 
    rownum,
    CEIL(DBMS_RANDOM.VALUE(1, 10) + 10),                              -- Random customer ID between 1 and 10
    CEIL(DBMS_RANDOM.VALUE(1, 10) + 10),                              -- Random rider ID between 1 and 10
    TO_DATE('1991-01-01', 'YYYY-MM-DD') + DBMS_RANDOM.VALUE(0, 11688) -- random date between 1st Jan 1991 and 31st Dec 2023
FROM dual
CONNECT BY level <= 100000;

COMMIT;
