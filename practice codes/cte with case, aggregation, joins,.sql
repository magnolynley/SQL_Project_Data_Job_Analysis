with dashboard_dataset as 
(SELECT
j.job_title_short jobtitle,
j.salary_year_avg as salary,
k.skills as skillname,

case 
when j.job_title_short like '%Senior%'
OR j.job_title_short LIKE '%Lead%'
OR j.job_title_short LIKE '%Principal%'
then 'Senior Level'
else 'General Level'
end as experiencetier

FROM
job_postings_fact as j

left join skills_job_dim as s on j.job_id = s.job_id
left join skills_dim as k on s.skill_id = k.skill_id

WHERE
k.skills IN ('tableau', 'power bi') and
j.salary_year_avg is not null)

SELECT
skillname,
experiencetier,
jobtitle,
round(avg(salary),2) as avgsalary,
count(jobtitle) as jobcount
from dashboard_dataset

group BY
 skillname,
 experiencetier,
 jobtitle

 order BY
 experiencetier DESC,
 avgsalary DESC