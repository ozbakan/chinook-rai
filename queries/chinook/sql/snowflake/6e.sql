-- Author:        Tolga Ozbakan
-- Date:          02-10-2022
-- Description:   Joins multiple relations. Shows the employees responsible for 
-- the highest invoice totals.

SELECT e.first_name,
    e.last_name,
    e.employee_id,
    to_char(hire_date::date, '%Y-%m-%d'),
    c.first_name,
    c.last_name,
    c.support_rep_id,
    i.customer_id,
    i.total::float8
FROM invoice AS i
    INNER JOIN customer AS c ON i.customer_id = c.customer_id
    INNER JOIN employee AS e ON c.support_rep_id = e.employee_id
ORDER BY
    i.total DESC,
    e.hire_date DESC
LIMIT 10