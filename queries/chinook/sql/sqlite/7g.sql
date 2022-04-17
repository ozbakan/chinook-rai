-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes yearly invoice averages in the USA.

select strftime('%Y', invoice_date),
    round(avg(total), 2)
from invoice
where billing_country = 'USA'
group by strftime('%Y', invoice_date)