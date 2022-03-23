-- Author:        Tolga Ozbakan
-- Date:          02-09-2022
-- Description:   Selects invoices on a given day.

select invoice_id,
    strftime('%Y-%m-%d', invoice_date),
    total
from invoice
where invoice_date = '2009-01-01'
