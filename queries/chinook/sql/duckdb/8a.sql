-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Returns invoices less that are below the average.

select invoice_id,
    billing_address,
    total::float8
from invoice
where total < (
        select avg(total)
        from invoice
    )