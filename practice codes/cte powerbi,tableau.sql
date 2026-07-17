with query1 as 
(SELECT
j.job_title_short as jobtitle,
j.salary_year_avg as avgsalary,
s.skills as skillname,
j.job_schedule_type as schedule
FROM
job_postings_fact as j
left join skills_job_dim as k on j.job_id = k.job_id
left join skills_dim as s on k.skill_id = s.skill_id
WHERE
skills in ('power bi', 'tableau') and 
salary_year_avg is not NULL
)
SELECT
count(jobtitle) as jobcount,
jobtitle,
skillname,
round(avg(avgsalary),2) as avgsalary
from 
query1
where 
schedule = 'Full-time'
group BY
skillname,
jobtitle
having
count(jobtitle) >5
order BY
jobtitle asc,
avgsalary DESC
