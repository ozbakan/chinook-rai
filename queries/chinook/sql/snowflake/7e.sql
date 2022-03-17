-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes average subtotals for cities beginning with 'B'.

select billing_city,
    round(avg(total::float8), 2)
from invoice
where billing_city like 'B%'
group by billing_city