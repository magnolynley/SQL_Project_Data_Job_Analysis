with skillsjob AS
(SELECT
job_id,
count(skill_id) as skillsavg

FROM
skills_job_dim

group BY
job_id)

SELECT
job_title_short,
round(avg(skillsavg), 1) as skillavg2,
round(avg(salary_year_avg), 2) as salaryavg

FROM
job_postings_fact

left join skillsjob on job_postings_fact.job_id = skillsjob.job_id

group by  
job_title_short

having
avg(salary_year_avg) > 100000 and 
avg(skillsavg) > 4

order BY
salaryavg DESC

limit 5
/*
always use the aggregate function in the select clause on having by function
like avg(skillsavg) so it wont flag syntax error and to avoid writing it in the groupby clause*/




