-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Returns invoices less that are below the average.

select invoice_id,
    billing_address,
    total
FROM invoice
WHERE total < (
        select avg(total)
        FROM invoice
    )