-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Returns tracks that are not in any of the invoices.


select
    track_id,
    composer
from
    track
where
    track_id not in (
        select
            distinct track_id
        from
            invoice_line
    )