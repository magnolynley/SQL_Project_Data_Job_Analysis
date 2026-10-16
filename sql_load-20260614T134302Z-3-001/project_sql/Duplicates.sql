/*
 * Question: How can we identify and audit duplicate skill names in the dataset to ensure data integrity?
 * - Objective: Use a CTE with GROUP BY and HAVING to find skills that appear more than once in the skills_dim table.
 * - Why?: Resolves data anomalies (e.g., duplicate entity records) to ensure accurate analysis and reliable job market metrics.
 */
 
with skilltable AS 
(SELECT
skills,
count(skills) as count

from 
skills_dim
group BY
skills
HAVING
count(skills) > 1)

Select
skill_ID,
skilltable.skills

from skilltable
inner join skills_dim on skilltable.skills = skills_dim.skills

