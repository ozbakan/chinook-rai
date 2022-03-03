-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes average subtotals for cities beginning with 'B' and
-- filters aggregate results.

SELECT billing_city,
    round(avg(total::float8), 2)
FROM invoice
WHERE billing_city LIKE 'B%'
GROUP BY billing_city
HAVING avg(total) > 5.5