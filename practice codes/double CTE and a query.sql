with job_market_clean as 
(SELECT
j.job_title_short as jobtitle,
j.salary_year_avg as salary,
s.skills as skillname,
case 
when j.job_title_short like '%Senior%'
or j.job_title_short like '%Lead%'
or j.job_title_short like '%Principal%'
then 'Executive_Track'
else 'Core_Track'
end as experience_tier

FROM
job_postings_fact as j

left join skills_job_dim as k on j.job_id = k.job_id
left join skills_dim as s on k.skill_id = s.skill_id
WHERE
s.skills in ('python', 'sql', 'excel') 
and j.salary_year_avg is not null),

skill_title_aggregates as 
(SELECT
skillname,
experience_tier,
count(jobtitle) as jobcount,
round(avg(salary),2) as avgsalary
from job_market_clean
group BY
skillname,
experience_tier,
jobtitle)
SELECT
skillname,
experience_tier,
sum(jobcount) as jobcount,
max(jobcount) as maxjob,
max(avgsalary) as avgsalary
from skill_title_aggregates
group BY
skillname,
experience_tier
order BY
jobcount DESC

