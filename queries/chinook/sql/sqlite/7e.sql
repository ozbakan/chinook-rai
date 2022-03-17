-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes average subtotals for cities beginning with 'B'.

select billing_city,
    round(avg(total), 2)
FROM invoice
WHERE billing_city LIKE 'B%'
group by billing_city