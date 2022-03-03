-- Author:        Tolga Ozbakan
-- Date:          02-09-2022
-- Description:   Selects invoices that between two dates.

SELECT invoice_id,
    to_char(invoice_date::date, '%Y-%m-%d'),
    total::float8
FROM invoice
WHERE invoice_date BETWEEN '2009-01-01' AND '2009-12-31'
