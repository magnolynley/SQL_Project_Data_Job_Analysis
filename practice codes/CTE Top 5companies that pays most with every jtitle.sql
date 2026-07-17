with jobskillscount as
    (SELECT
    job_id,
    count(skill_id) as totalskills
    from skills_job_dim
    group BY
    job_id
    having 
    count(skill_id) > 2)

select 
    name,
    round(avg(salary_year_avg),2)

from 
    job_postings_fact

    left join jobskillscount on job_postings_fact.job_id = jobskillscount.job_id
    left join company_dim on job_postings_fact.company_id = company_dim.company_id

where
    salary_year_avg is not null

group by 
    name
    
 having
 avg(salary_year_avg)> 120000
 order by
 round(avg(salary_year_avg),2) DESC
 limit 5

