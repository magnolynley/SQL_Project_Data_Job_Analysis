
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

