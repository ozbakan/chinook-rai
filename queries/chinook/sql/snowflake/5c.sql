-- Author:        Tolga Ozbakan
-- Date:          02-09-2022
-- Description:   Selects invoices that are between two dates.

select
    invoice_id,
    to_char(invoice_date, '%Y-%m-%d'),
    total :: float8
from
    invoice
where
    invoice_date between '2009-01-01'
    and '2009-12-31'