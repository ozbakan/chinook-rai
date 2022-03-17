-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Computes average subtotals for invoice dates and countries.

select strftime(invoice_date::date, '%Y-%m-%d'),
    billing_country,
    avg(total)
from invoice
group by billing_country, invoice_date