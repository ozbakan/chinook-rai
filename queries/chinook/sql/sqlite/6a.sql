-- Author:      Tolga Ozbakan
-- Date:        02-09-2022
-- Description: Joins relations. This will produce 412 records, one for 
-- each invoice.

select c.last_name,
    c.first_name,
    c.email,
    i.customer_id,
    i.invoice_id,
    i.total
from invoice as i
    inner join customer as c 
    on i.customer_id = c.customer_id