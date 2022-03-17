-- Author:        Tolga Ozbakan
-- Date:          02-10-2022
-- Description:   Joins multiple relations. Shows the employees responsible for 
-- the highest invoice totals.

select e.first_name,
    e.last_name,
    e.employee_id,
    date(e.hire_date),
    c.first_name,
    c.last_name,
    c.support_rep_id,
    i.customer_id,
    i.total
from invoice as i
    inner join customer as c on i.customer_id = c.customer_id
    inner join employee as e on c.support_rep_id = e.employee_id
order by
    i.total desc,
    e.hire_date desc
limit 10