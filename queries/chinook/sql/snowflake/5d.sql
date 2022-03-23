-- Author:        Tolga Ozbakan
-- Date:          02-09-2022
-- Description:   Selects invoices on a given day.

select invoice_id,
    to_char(invoice_date, '%Y-%m-%d'),
    total::float8
from invoice
where invoice_date = '2009-01-01'
