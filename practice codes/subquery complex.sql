SELECT
name as companyNAME,
countA

FROM
company_dim

left join(

SELECT
job_id,
company_id,
count(*) as countA

FROM
job_postings_fact

WHERE
salary_year_avg > 100000

group BY
job_id,
company_id

limit 10

 ) as  tablesub on company_dim.company_id = tablesub.company_id
 left join skills_job_dim on tablesub.job_id = skills_job_dim.job_id
 left join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

 WHERE
 skills <> 'sql'

group BY
companyNAME,
countA
Order by 
countA DESC
limit 3
