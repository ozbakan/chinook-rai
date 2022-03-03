-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes yearly invoice averages in the USA.

SELECT to_char(invoice_date, '%Y'),
    round(avg(total::float), 2)
FROM invoice
WHERE billing_country = 'USA'
GROUP BY invoice_date