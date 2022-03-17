-- Author:        Tolga Ozbakan
-- Date:          02-09-2022
-- Description:   Selects invoices on a given day.

select invoice_id,
    date(invoice_date),
    total
FROM invoice
WHERE date(invoice_date) = '2009-01-01'
