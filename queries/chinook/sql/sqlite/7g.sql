-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes yearly invoice averages in the USA.

SELECT strftime('%Y', invoice_date),
    round(avg(total), 2)
FROM invoice
WHERE billing_country = 'USA'
GROUP BY invoice_date