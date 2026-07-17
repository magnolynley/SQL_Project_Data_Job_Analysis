with jobtable AS
(SELECT
job_id,
salary_year_avg,
case
when job_location = 'Anywhere' then 'Remote'
else 'Local'
end as location_category
FROM
job_postings_fact
WHERE
salary_year_avg is not NULL)
SELECT
location_category,
skills,
round(avg(salary_year_avg), 2)
FROM
jobtable
LEFT JOIN skills_job_dim on jobtable.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

where
skills in ('python', 'sql')
group BY
location_category,
skills
order by 
skills asc,
round(avg(salary_year_avg), 2) desc