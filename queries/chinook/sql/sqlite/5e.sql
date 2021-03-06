-- Author:      Tolga Ozbakan
-- Date:        02-09-2022
-- Description: Creates a purchase type column conditonally.

select invoice_id,
    total,
    case
        when total <= 1.99 then 'Low'
        when total between 2.00 and 6.99 then 'Mid'
        else 'High'
    end as 'Purchase Type'
from invoice