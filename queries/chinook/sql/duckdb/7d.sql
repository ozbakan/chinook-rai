-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes ages of employees.

select last_name,
    first_name,
    strftime(birth_date::date, '%Y-%m-%d'),
    date_diff('year', birth_date::date, current_date)
from employee