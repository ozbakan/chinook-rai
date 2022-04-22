-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes yearly invoice averages in the USA.

select strftime(invoice_date, '%Y'),
    round(avg(total), 2)
from invoice
where billing_country = 'USA'
group by strftime(invoice_date, '%Y')