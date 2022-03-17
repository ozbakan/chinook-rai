-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes yearly invoice averages in the USA.

select to_char(invoice_date, '%Y'),
    round(avg(total::float), 2)
from invoice
where billing_country = 'USA'
group by invoice_date