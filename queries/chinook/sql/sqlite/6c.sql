-- Author:      Tolga Ozbakan
-- Date:        02-09-2022
-- Description: Selects artists and their albums using left join.There is 
-- one-to-many relationship between 275 artists and 347 albums. Some artists
-- have multiple albums, but there are 71 artists (e.g. João Gilberto, id of 28)
-- without any albums. This left join will include all artists, whether they
-- have an album or not.

select a.name,
    b.title
FROM artist AS a
    LEFT JOIN album AS b 
    on a.artist_id = b.artist_id