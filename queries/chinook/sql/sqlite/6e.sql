-- Author:        Tolga Ozbakan
-- Date:          02-10-2022
-- Description:   Joins multiple relations. Shows the employees responsible for 
-- the highest invoice totals.

select e.first_name,
    e.last_name,
    e.employee_id,
    DATE(e.hire_date),
    c.first_name,
    c.last_name,
    c.support_rep_id,
    i.customer_id,
    i.total
FROM invoice AS i
    INNER JOIN customer AS c on i.customer_id = c.customer_id
    INNER JOIN employee AS e on c.support_rep_id = e.employee_id
ORDER BY
    i.total DESC,
    e.hire_date DESC
LIMIT 10