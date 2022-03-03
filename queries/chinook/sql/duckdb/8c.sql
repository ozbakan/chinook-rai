-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes largest sale between 2009 and 2011 and returns 
-- invoices that are higher than that value in the following years.

SELECT strftime(invoice_date::date, '%Y-%m-%d'),
    billing_city,
    total::float8
FROM invoice
WHERE invoice_date >= '2012-01-01'
    AND total > (
        SELECT max(total::float8)
        FROM invoice
        WHERE invoice_date < '2012-01-01'
    )