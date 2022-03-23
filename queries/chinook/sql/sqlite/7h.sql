-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes average subtotals for invoice dates and countries.

select strftime('%Y-%m-%d', invoice_date),
    billing_country,
    avg(total)
from invoice
group by billing_country, invoice_date