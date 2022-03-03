-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes average subtotals for invoice dates and countries.

SELECT to_char(invoice_date::date, '%Y-%m-%d'),
    billing_country,
    avg(total::float8)
FROM invoice
GROUP BY billing_country, invoice_date