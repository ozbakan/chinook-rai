-- Author:        Tolga Ozbakan
-- Date:          02-11-2022
-- Description:   Creates a view for invoice averages.

CREATE VIEW IF NOT EXISTS v_avg_total AS
SELECT round(avg(total), 2)
FROM invoice