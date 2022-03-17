-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Truncates postal code to five characters.

select postal_code,
    substr(postal_code, 1, 5)
from customer
where country = 'USA'