-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Returns invoices on the invoice dates of multiple invoice ids.

select invoice_id,
    date(invoice_date),
    billing_address,
    billing_city
from invoice
where invoice_date in (
        select invoice_date
        from invoice
        where invoice_id in (251, 252, 255)
    )