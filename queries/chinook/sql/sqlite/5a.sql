-- Author:       Tolga Ozbakan
-- Date:         02-09-2022
-- Description:  Computes a new relation, by relating an invoice to its tax.

SELECT invoice_id,
    billing_country,
    billing_city,
    total,
    round(total * 1.15, 2)
FROM invoice
WHERE billing_country IN ('Belgium', 'France')