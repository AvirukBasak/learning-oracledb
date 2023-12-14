-- This worksheet inserts and sets up customer, rider and order data

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

SELECT * FROM nls_session_parameters WHERE parameter = 'NLS_DATE_FORMAT';
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

-- Insert 10 dummy records into the customer table
INSERT ALL
    INTO customer (id, email, mobile, dob, location) VALUES (1, 'customer1@example.com', '1234567890', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Location1')
    INTO customer (id, email, mobile, dob, location) VALUES (2, 'customer2@example.com', '2345678901', TO_DATE('1985-02-15', 'YYYY-MM-DD'), 'Location2')
    INTO customer (id, email, mobile, dob, location) VALUES (3, 'customer3@example.com', '3456789012', TO_DATE('1992-04-30', 'YYYY-MM-DD'), 'Location3')
    INTO customer (id, email, mobile, dob, location) VALUES (4, 'customer4@example.com', '4567890123', TO_DATE('1988-06-22', 'YYYY-MM-DD'), 'Location4')
    INTO customer (id, email, mobile, dob, location) VALUES (5, 'customer5@example.com', '5678901234', TO_DATE('1995-08-10', 'YYYY-MM-DD'), 'Location5')
    INTO customer (id, email, mobile, dob, location) VALUES (6, 'customer6@example.com', '6789012345', TO_DATE('1991-10-05', 'YYYY-MM-DD'), 'Location6')
    INTO customer (id, email, mobile, dob, location) VALUES (7, 'customer7@example.com', '7890123456', TO_DATE('1987-12-18', 'YYYY-MM-DD'), 'Location7')
    INTO customer (id, email, mobile, dob, location) VALUES (8, 'customer8@example.com', '8901234567', TO_DATE('1994-03-25', 'YYYY-MM-DD'), 'Location8')
    INTO customer (id, email, mobile, dob, location) VALUES (9, 'customer9@example.com', '9012345678', TO_DATE('1989-07-14', 'YYYY-MM-DD'), 'Location9')
    INTO customer (id, email, mobile, dob, location) VALUES (10, 'customer10@example.com', '0123456789', TO_DATE('1993-09-03', 'YYYY-MM-DD'), 'Location10')
SELECT 1 FROM Dual;

INSERT ALL
    INTO rider (id, email, mobile, dob, location) VALUES (1, 'rider1@example.com', '1234567890', TO_DATE('1995-01-15', 'YYYY-MM-DD'), 'Location 1')
    INTO rider (id, email, mobile, dob, location) VALUES (2, 'rider2@example.com', '2345678901', TO_DATE('1990-05-22', 'YYYY-MM-DD'), 'Location 2')
    INTO rider (id, email, mobile, dob, location) VALUES (3, 'rider3@example.com', '3456789012', TO_DATE('1997-09-10', 'YYYY-MM-DD'), 'Location 3')
    INTO rider (id, email, mobile, dob, location) VALUES (4, 'rider4@example.com', '4567890123', TO_DATE('1992-03-18', 'YYYY-MM-DD'), 'Location 4')
    INTO rider (id, email, mobile, dob, location) VALUES (5, 'rider5@example.com', '5678901234', TO_DATE('1999-08-10', 'YYYY-MM-DD'), 'Location 5')
    INTO rider (id, email, mobile, dob, location) VALUES (6, 'rider6@example.com', '6789012345', TO_DATE('1996-10-05', 'YYYY-MM-DD'), 'Location 6')
    INTO rider (id, email, mobile, dob, location) VALUES (7, 'rider7@example.com', '7890123456', TO_DATE('1991-12-18', 'YYYY-MM-DD'), 'Location 7')
    INTO rider (id, email, mobile, dob, location) VALUES (8, 'rider8@example.com', '8901234567', TO_DATE('1998-03-25', 'YYYY-MM-DD'), 'Location 8')
    INTO rider (id, email, mobile, dob, location) VALUES (9, 'rider9@example.com', '9012345678', TO_DATE('1993-07-14', 'YYYY-MM-DD'), 'Location 9')
    INTO rider (id, email, mobile, dob, location) VALUES (10, 'rider10@example.com', '0123456789', TO_DATE('1994-09-03', 'YYYY-MM-DD'), 'Location 10')
    INTO rider (id, email, mobile, dob, location) VALUES (11, 'rider11@example.com', '1234567801', TO_DATE('1996-02-20', 'YYYY-MM-DD'), 'Location 11')
    INTO rider (id, email, mobile, dob, location) VALUES (12, 'rider12@example.com', '2345678012', TO_DATE('1992-04-05', 'YYYY-MM-DD'), 'Location 12')
    INTO rider (id, email, mobile, dob, location) VALUES (13, 'rider13@example.com', '3456780123', TO_DATE('1990-06-15', 'YYYY-MM-DD'), 'Location 13')
    INTO rider (id, email, mobile, dob, location) VALUES (14, 'rider14@example.com', '4567801234', TO_DATE('1995-08-25', 'YYYY-MM-DD'), 'Location 14')
    INTO rider (id, email, mobile, dob, location) VALUES (15, 'rider15@example.com', '5678012345', TO_DATE('1998-10-10', 'YYYY-MM-DD'), 'Location 15')
    INTO rider (id, email, mobile, dob, location) VALUES (16, 'rider16@example.com', '6780123456', TO_DATE('1994-12-22', 'YYYY-MM-DD'), 'Location 16')
    INTO rider (id, email, mobile, dob, location) VALUES (17, 'rider17@example.com', '7890123456', TO_DATE('1991-01-08', 'YYYY-MM-DD'), 'Location 17')
    INTO rider (id, email, mobile, dob, location) VALUES (18, 'rider18@example.com', '8901234567', TO_DATE('1997-03-15', 'YYYY-MM-DD'), 'Location 18')
    INTO rider (id, email, mobile, dob, location) VALUES (19, 'rider19@example.com', '9012345678', TO_DATE('1993-05-18', 'YYYY-MM-DD'), 'Location 19')
    INTO rider (id, email, mobile, dob, location) VALUES (20, 'rider20@example.com', '0123456789', TO_DATE('1999-07-30', 'YYYY-MM-DD'), 'Location 20')
SELECT 1 FROM Dual;

-- Assuming you have customer and rider tables with IDs ranging from 1 to 10
-- Adjust the table and column names accordingly if they are different in your database.

-- Insert 100 orders with random customer and rider IDs
INSERT INTO orders (id, customer_id, rider_id)
SELECT 
    rownum,
    CEIL(DBMS_RANDOM.VALUE(1, 10)), -- Random customer ID between 1 and 10
    CEIL(DBMS_RANDOM.VALUE(1, 10))  -- Random rider ID between 1 and 10
FROM dual
CONNECT BY level <= 100000;

-- TRUNCATE TABLE orders;

COMMIT;
