-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Returns tracks that are not in any of the invoices.

select track_id,
    composer,
    name
from track
where track_id notin (
        select DISTINCT track_id
        from invoice_line
    )