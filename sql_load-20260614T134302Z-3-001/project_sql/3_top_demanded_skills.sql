/*Question: What are the most in-demand skilss for data analyst?
- Join job postings to inner join table similar to query2.
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings
- Why? Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.
*/

SELECT 
skills,
COUNT(skills_job_dim.job_id) AS demand_count

FROM 
job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
job_title_short = 'Data Analyst' AND
job_work_from_home = True

GROUP BY
skills

ORDER BY
demand_count DESC

LIMIT 10
/*
Here's the breakdown of the most in-demand skills overall:
SQL Dominance: SQL leads with 7,291 job mentions, outpacing the second most demanded skill by over 58%. It remains the single most critical technical skill for landing a data analyst role.
Core Foundation Pair: SQL and Excel together represent over 52% of total demand among the top 5 skills, proving that data querying and spreadsheet processing form the baseline requirement for most positions.
Programming vs. Visualization: Python (4,330 mentions) slightly edges out Tableau (3,745 mentions), reflecting a high employer demand for programmatic data handling alongside dashboarding capabilities.
BI Tool Split: Tableau leads Power BI by 1,136 postings (a 43.5% lead in demand), though both remain essential enterprise visualization standards.
*/