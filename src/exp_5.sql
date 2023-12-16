-- 1. find email of rider with most deliveries
WITH t AS (
    SELECT r.id, r.mobile, r.email, r.salary, COUNT(*) AS total_deliveries
    FROM rider r JOIN orders o ON r.id = o.rider_id
    GROUP BY r.id, r.mobile, r.email, r.salary
)
SELECT *
FROM t
WHERE total_deliveries = (SELECT MAX(total_deliveries) FROM t);
