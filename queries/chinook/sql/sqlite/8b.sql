-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Displays global average as a new element.

SELECT billing_country,
    round(avg(total), 2),
    (
        SELECT round(avg(total), 2)
        FROM invoice
    ) 
FROM invoice
GROUP BY billing_country