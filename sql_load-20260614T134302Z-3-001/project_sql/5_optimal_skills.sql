/*Answer: What are the most optimal skills to learn(aka it's in high demand and high-paying skill)?
-Identify skills in high demand and associated with high average salaries for data analyst roles
-Concentrates on remote positions with specified salaries
-Why? Targets skills that offer job seurity(high demand) and financial benefits(high salaries), offering strategic insights for career development in data analysis.
*/
WITH skills_demand AS 
    (SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count

    FROM 
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    
    WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True

    GROUP BY
    skills_dim.skill_id
   
    ),

 average_salary AS
    (SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary

    FROM 
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    
    WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True
    
    GROUP BY
    skills_dim.skill_id
   
    )
SELECT
skills_demand.skill_id,
skills_demand.skills,
skills_demand.demand_count,
average_salary.avg_salary

FROM skills_demand

INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id

WHERE
demand_count>10

ORDER BY
demand_count DESC,
avg_salary DESC

LIMIT 25



/*rewritten query- shorter version*/
SELECT
skills_dim.skill_id,
skills,
COUNT(skills_job_dim.job_id) AS demand_count,
ROUND(AVG(salary_year_avg),0) AS avg_salary

FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
job_title_short = 'Data Analyst'
AND job_work_from_home = 'True'
AND salary_year_avg IS NOT NULL

GROUP BY
skills_dim.skill_id

HAVING
COUNT(skills_job_dim.job_id) > 10

ORDER BY
demand_count DESC,
avg_salary DESC

LIMIT 25;

/*rewritten query, avoiding SAS duplicates*/

SELECT
LOWER(skills_dim.skills) AS skills_name,
COUNT(skills_job_dim.job_id) AS demand_count,
ROUND(AVG(salary_year_avg),0) AS avg_salary

FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id =skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
job_title_short = 'Data Analyst'
AND job_work_from_home = 'True'
AND salary_year_avg IS NOT NULL

GROUP BY
LOWER(skills_dim.skills)

HAVING
count(skills_job_dim.job_id) > 10

ORDER BY
demand_count DESC,
avg_salary DESC

LIMIT 25;