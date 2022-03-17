-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Returns tracks that are not in any of the invoices.

select track_id,
    composer,
    name
FROM track
WHERE track_id NOT IN (
        select DISTINCT track_id
        FROM invoice_line
    )