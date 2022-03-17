-- Author:      Tolga Ozbakan
-- Date:        02-09-2022
-- Description: Creates a purchase type column based on invoice total.

select invoice_id,
    total,
    case
        when total < 1.99 then 'Low'
        when total BETWEEN 2.00 AND 6.99 then 'Middle'
        else 'High'
    end AS 'Purchase Type'
FROM invoice