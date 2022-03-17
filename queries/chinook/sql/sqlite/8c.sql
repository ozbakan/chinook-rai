-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes largest sale between 2009 and 2011 and returns 
-- invoices that are higher than that value in the following years.

select date(invoice_date),
    billing_city,
    total
from invoice
where invoice_date >= '2012-01-01'
    and total > (
        select max(total)
        from invoice
        where invoice_date < '2012-01-01'
    )