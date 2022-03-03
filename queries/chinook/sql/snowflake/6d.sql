-- Author:        Tolga Ozbakan
-- Date:          02-10-2022
-- Description:   Shows the artists that have no albums.

SELECT a.name
FROM artist AS a
    LEFT JOIN album AS b ON a.artist_id = b.artist_id
WHERE b.artist_id IS NULL