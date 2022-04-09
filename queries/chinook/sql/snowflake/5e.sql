-- Author:      Tolga Ozbakan
-- Date:        02-09-2022
-- Description: Creates a purchase type column based on invoice total.

select invoice_id,
    total::float8,
    case
        when total <= 1.99 then 'Low'
        when total between 2.00 and 6.99 then 'Mid'
        when total > 6.99 then 'High'
    end as result
from invoice