-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes largest sale between 2009 and 2011 and returns 
-- invoices that are higher than that value in the following years.

SELECT DATE(invoice_date),
    billing_city,
    total
FROM invoice
WHERE invoice_date >= '2012-01-01'
    AND total > (
        SELECT max(total)
        FROM invoice
        WHERE invoice_date < '2012-01-01'
    )