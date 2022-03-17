-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Concatenates the first and last names of customers in the USA.

select 
    first_name || ' ' || last_name
FROM customer
WHERE country = 'USA'