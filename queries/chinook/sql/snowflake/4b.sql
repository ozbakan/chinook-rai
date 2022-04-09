-- Author:       Tolga Ozbakan
-- Date:         02-08-2022
-- Description:  Selects N binary tuples from relation sorted by element

select
    name,
    bytes
from
    track
order by
    bytes desc
limit
    10