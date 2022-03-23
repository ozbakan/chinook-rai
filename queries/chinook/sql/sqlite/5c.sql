-- Author:        Tolga Ozbakan
-- Date:          02-09-2022
-- Description:   Selects invoices between two dates.

select invoice_id,
    strftime('%Y-%m-%d', invoice_date),
    total
from invoice
where invoice_date between '2009-01-01' and '2009-12-31'
