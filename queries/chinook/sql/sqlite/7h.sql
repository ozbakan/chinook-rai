-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes average subtotals for invoice dates and countries.

SELECT DATE(invoice_date),
    billing_country,
    avg(total)
FROM invoice
GROUP BY billing_country, invoice_date