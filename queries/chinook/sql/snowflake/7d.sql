-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes ages of employees.

select last_name,
    first_name,
    to_char(birth_date, '%Y-%m-%d'),
    datediff('year', birth_date, current_date)
from employee