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
Name AS company_name
FROM
job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
job_title_short LIKE 'Data Analyst' AND
job_location = 'Anywhere'  AND
salary_year_avg IS NOT NULL
ORDER BY
salary_year_avg desc
LIMIT 10

/*
Here's the breakdown of the top-paying Data Analyst roles in the dataset:
Salary Range: Annual compensation across the top 10 roles ranges from $184,000 to $650,000.
Top Earners: Data Analyst at Mantys commands the highest annual salary at $650,000, followed by Director of Analytics at Meta at $336,500.
Prominent Employers: Major enterprise listings include AT&T ($255,830), Pinterest ($232,423), UCLA Health ($217,000), and SmartAsset ($205,000).
Seniority Premium: Leadership and principal titles (e.g., Director, Associate Director, and Principal Analyst) represent the majority of high-compensation opportunities.
*/