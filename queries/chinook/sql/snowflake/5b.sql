-- Author:        Tolga Ozbakan
-- Date:          02-09-2022
-- Description:   Selects invoices that contain the letter 'ß' in address.

select
    invoice_id,
    billing_address,
    total :: float8
from
    invoice
where
    billing_address like '%ß%'