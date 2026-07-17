with raw_job_stream as 
(SELECT
j.job_title_short as jobtitle,
j.salary_year_avg as salary,
s.skills as skillname,
CASE
when j.job_title_short like '%Senior%'
or j.job_title_short like '%Lead%'
or j.job_title_short like '%Principal%'
then 'Senior-Tier'
else 'Junior-Tier'
end as experience_tier
FROM
job_postings_fact as j

left join skills_job_dim as k on j.job_id = k.job_id
left join skills_dim as s on k.skill_id = s.skill_id
WHERE
j.salary_year_avg is not NULL
and s.skills in ('python','tableau','power bi')
),
title_summaries as
(SELECT
skillname,
experience_tier,
count(jobtitle) as jobcount,
round(avg(salary),2) as salaryavg
from raw_job_stream
group by
skillname,
experience_tier,
jobtitle
)
SELECT
skillname,
experience_tier,
sum(jobcount) as totaltierjobs,
max(salaryavg) as premiumsalarycap
from title_summaries
group by 
skillname,
experience_tier
order by
premiumsalarycap desc