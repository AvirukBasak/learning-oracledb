SELECT * FROM employee SAMPLE(15);
SELECT * FROM department SAMPLE(99);

-- 1. who earns max sal of 'Department 5'?
SELECT *
FROM employee
WHERE salary = (
    SELECT MAX(salary)
    FROM employee e JOIN department d ON e.dept_id = d.id
    WHERE d.name = 'Department 5'
);

-- 1.5. alternative
SELECT *
FROM employee
WHERE salary = (
    SELECT MAX(salary)
    FROM employee
    WHERE dept_id = (
        SELECT id
        FROM department
        WHERE name = 'Department 5'
    )
);

-- who earns max salary of their dept?
WITH t AS(
    SELECT
        e.dept_id as dept_id,
        d.name as dept_name,
        MAX(salary) as max_salary
    FROM employee e JOIN department d ON e.dept_id = d.id
    GROUP BY e.dept_id, d.name
)
SELECT *
FROM employee e JOIN t ON
    e.dept_id = t.dept_id
    AND
    e.salary = t.max_salary;

-- get department strength
SELECT d.name, COUNT(*) AS strength
FROM employee e RIGHT JOIN department d ON e.dept_id = d.id
GROUP BY d.id, d.name
ORDER BY d.id;

-- who earns over the avg salary of their dept?
WITH t AS (
    SELECT
        dept_id,
        d.name AS dept_name,
        AVG(salary) AS avg_sal
    FROM employee e JOIN department d ON e.dept_id = d.id
    GROUP BY dept_id, d.name
)
SELECT *
FROM employee e JOIN t ON
    e.dept_id = t.dept_id
    AND
    salary > avg_sal;

-- who earns over the max salary of their dept?
    SELECT
      d.id as dept_id
    , d.name
    , d.location
    , MAX(e.salary) AS max_salary
    FROM department d INNER JOIN employee e ON e.dept_id = d.id
    GROUP BY d.name, d.location, d.id;

SELECT 
    m.*, e.*
FROM (
    SELECT
      d.id as dept_id
    , d.name
    , d.location
    , MAX(e.salary) AS max_salary
    FROM department d INNER JOIN employee e ON e.dept_id = d.id
    GROUP BY d.name, d.location, d.id
) M
INNER JOIN employee e on
    e.dept_id = m.dept_id
    AND
    e.salary = m.max_salary;
