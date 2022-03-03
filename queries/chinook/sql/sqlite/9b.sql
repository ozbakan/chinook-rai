-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Uses a view to returns invoices that are less then the average
-- of all invoices.
 
SELECT invoice_id,
    billing_address,
    total
FROM invoice
WHERE total < (
        SELECT *
        FROM v_avg_total
    )