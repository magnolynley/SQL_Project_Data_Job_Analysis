with t1 as 
(SELECT
job_id,
salary_year_avg,
job_title_short
from january_jobs
union ALL
SELECT
job_id,
salary_year_avg,
job_title_short
from february_jobs
union ALL
SELECT
job_id,
salary_year_avg,
job_title_short

from march_jobs)

SELECT
t.job_id as job_id,
s.skills as skillname,
k.skill_id as skillid,
t.salary_year_avg as salary
from t1 as t
left join skills_job_dim as k on t.job_id=k.job_id
left join skills_dim as s on k.skill_id=s.skill_id
WHERE
salary_year_avg > 70000
