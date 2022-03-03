-- Author:      Tolga Ozbakan
-- Date:        02-09-2022
-- Description: Creates a purchase type column based on invoice total.

SELECT invoice_id,
    total,
    CASE
        WHEN total < 1.99 THEN 'Low'
        WHEN total BETWEEN 2.00 AND 6.99 THEN 'Middle'
        ELSE 'High'
    END AS 'Purchase Type'
FROM invoice