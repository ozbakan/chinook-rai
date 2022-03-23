-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes ages of employees.

select last_name,
    first_name,
    strftime('%Y-%m-%d', birth_date),
    date('now') - birth_date
from employee