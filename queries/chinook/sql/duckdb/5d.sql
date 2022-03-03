-- Author:        Tolga Ozbakan
-- Date:          02-09-2022
-- Description:   Selects invoices on a given day.

SELECT invoice_id,
    strftime(invoice_date::date, '%Y-%m-%d'),
    total::float8
FROM invoice
WHERE invoice_date::date = '2009-01-01'
