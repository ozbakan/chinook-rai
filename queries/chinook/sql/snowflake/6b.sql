-- Author:      Tolga Ozbakan
-- Date:        02-09-2022
-- Description: Selects artists and their albums using inner join.There is 
-- one-to-many relationship between 275 artists and 347 albums. Some artists
-- have multiple albums, but there are 71 artists (e.g. João Gilberto, id of 28)
-- without any albums. This inner join will ignore the artists without albums
-- so we will create 347 rows.

select
    a.name,
    b.title
from
    artist as a
    inner join album as b on a.artist_id = b.artist_id