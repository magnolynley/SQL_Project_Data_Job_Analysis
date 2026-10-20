 /*
 Question: How can we identify and audit duplicate skill names in the dataset to ensure data integrity?
  - Objective: Use a CTE with GROUP BY and HAVING to find skills that appear more than once in the skills_dim table.
  - Why?: Resolves data anomalies (e.g., duplicate entity records) to ensure accurate analysis and reliable job market metrics.
 */

WITH skilltable AS 
(SELECT
replace(lower(skills),' ','') as skills,
COUNT(skills) AS count

FROM 
skills_dim

GROUP BY
replace(lower(skills),' ','')

HAVING
count(skills) > 1)


SELECT
skill_ID,
skilltable.skills,
count

FROM skilltable
INNER JOIN skills_dim ON skilltable.skills = replace(lower(skills_dim.skills),' ','')

