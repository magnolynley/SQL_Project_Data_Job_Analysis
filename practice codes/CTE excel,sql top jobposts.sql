with skillpostings as 
(SELECT
j.job_id, 
j.job_title_short,
j.salary_year_avg,
s.skills as skillname
FROM
job_postings_fact as j
left join skills_job_dim as k on j.job_id = k.job_id
left join skills_dim as s on k.skill_id = s.skill_id
where
s.skills in ('sql', 'excel') and
salary_year_avg is not null
order by
salary_year_avg desc)

select 
skillname,
job_title_short as jobtitle,
round(avg(salary_year_avg),2) as avgsalary,
count(job_title_short) as jobcount
FROM
skillpostings
group BY
job_title_short,
skillname

HAVING
count(job_title_short) > 10 
order BY
avgsalary desc
limit 100

