-- Author:        Tolga Ozbakan
-- Date:          02-09-2022
-- Description:   Selects invoices that contain the letter 'ß' in address.

SELECT invoice_id,
    billing_address,
    total
FROM invoice
WHERE billing_address LIKE '%ß%'