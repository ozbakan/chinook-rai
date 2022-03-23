-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes largest sale between 2009 and 2011 and returns 
-- invoices that are higher than that value in the following years.

select strftime(invoice_date, '%Y-%m-%d'),
    billing_city,
    total::float8
from invoice
where invoice_date >= '2012-01-01'
    and total > (
        select max(total::float8)
        from invoice
        where invoice_date < '2012-01-01'
    )