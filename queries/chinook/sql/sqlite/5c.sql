-- Author:        Tolga Ozbakan
-- Date:          02-09-2022
-- Description:   Selects invoices that between two dates.

SELECT invoice_id,
    date(invoice_date),
    total
FROM invoice
WHERE invoice_date BETWEEN '2009-01-01' AND '2009-12-31'
