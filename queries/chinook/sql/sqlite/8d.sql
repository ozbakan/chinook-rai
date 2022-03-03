-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Returns invoices on the invoice dates of multiple invoice ids.

SELECT invoice_id,
    DATE(invoice_date),
    billing_address,
    billing_city
FROM invoice
WHERE invoice_date IN (
        SELECT invoice_date
        FROM invoice
        WHERE invoice_id IN (251, 252, 255)
    )