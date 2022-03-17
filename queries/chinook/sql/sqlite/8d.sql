-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Returns invoices on the invoice dates of multiple invoice ids.

select invoice_id,
    DATE(invoice_date),
    billing_address,
    billing_city
FROM invoice
WHERE invoice_date IN (
        select invoice_date
        FROM invoice
        WHERE invoice_id IN (251, 252, 255)
    )