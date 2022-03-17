-- Author:        Tolga Ozbakan
-- Date:          02-10-2022
-- Description:   Basic aggregations, including counts of null elements.

select round(sum(total), 2),
    round(avg(total), 2),
    round(max(total), 2),
    count(*),
    count(total),
    count(billing_state),
    count(billing_postal_code)
from invoice