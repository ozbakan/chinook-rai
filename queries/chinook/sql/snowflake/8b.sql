-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Displays global average as a new element.

select billing_country,
    round(avg(total::float8), 2),
    (
        select round(avg(total::float8), 2)
        from invoice
    ) 
from invoice
group by billing_country