-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Returns invoices less that are below the average.

SELECT invoice_id,
    billing_address,
    total
FROM invoice
WHERE total < (
        SELECT avg(total)
        FROM invoice
    )