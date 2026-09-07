/*Question:What are the top paying jobs for my role?
-Identify the top 10 highest paying Data Analyst roles that are available remotely.
-Focuses on job postings with specified salaries (remove nulls)
-Why? Highlight the top paying opportunities for Data Analysts, offering...
*/
SELECT
job_id,
job_title,
salary_year_avg,
job_location,
job_schedule_type,
job_posted_date,
name as company_name
From
job_postings_fact
left join company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE
job_title_short like 'Data Analyst' AND
job_location = 'Anywhere'  AND
salary_year_avg is not NULL
order BY
salary_year_avg desc
limit 10