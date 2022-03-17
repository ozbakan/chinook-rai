-- Author:        Tolga Ozbakan
-- Date:          02-10-2022
-- Description:   Shows the artists that have no albums.

select a.name
from artist as a
    left join album as b on a.artist_id = b.artist_id
where b.artist_id IS null