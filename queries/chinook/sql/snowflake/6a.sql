-- Author:      Tolga Ozbakan
-- Date:        02-09-2022
-- Description: Joins relations. This will produce 412 records, one for 
-- each invoice.

SELECT c.last_name,
    c.first_name,
    c.email,
    i.customer_id,
    i.invoice_id,
    i.total::float8
FROM invoice as i
    INNER JOIN customer as c 
    ON i.customer_id = c.customer_id