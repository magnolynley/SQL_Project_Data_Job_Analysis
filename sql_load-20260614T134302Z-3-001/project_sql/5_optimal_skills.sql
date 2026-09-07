/*Answer: What are the most optimal skills to learn(aka it's in high demand and high-paying skill)?
-Identify skills in high demand and associated with high average salaries for data analyst roles
-Concentrates on remote positions with specified salaries
-Why? Targets skills that offer job seurity(high demand) and financial benefits(high salaries), offering strategic insights for career development in data analysis.
*/
with skills_demand as 
    (Select 
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count
    from 
    job_postings_fact
    inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg is not null AND
    job_work_from_home = True
    group BY
    skills_dim.skill_id
   
    ),

 average_salary as
    (Select 
    skills_dim.skill_id,
    skills_dim.skills,
    round(avg(salary_year_avg),0) as avg_salary

    from 
    job_postings_fact
    inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg is not NULL AND
    job_work_from_home = True
    
    group BY
    skills_dim.skill_id
   
    )
SELECT
skills_demand.skill_id,
skills_demand.skills,
skills_demand.demand_count,
average_salary.avg_salary

from skills_demand

INNER JOIN average_salary on skills_demand.skill_id = average_salary.skill_id
WHERE
demand_count>10
order BY
avg_salary desc,
demand_count DESC

limit 25

/*rewrite query*/
Select
skills_dim.skill_id,
skills,
count(skills_dim.skill_id) as demand_count,
round(avg(salary_year_avg),0) as avg_salary

from job_postings_fact
left join skills_job_dim on job_postings_fact.job_id =skills_job_dim.job_id
left join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

WHERE
job_title_short = 'Data Analyst'
and job_work_from_home = 'True'
and salary_year_avg is not null

group by
skills_dim.skill_id

having
count(skills_dim.skill_id) > 10
order by
avg_salary desc,
demand_count desc