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

LIMIT 25;



/*rewritten query- shorter version*/
SELECT
skills_dim.skill_id,
skills_dim.skills,
COUNT(skills_job_dim.job_id) AS demand_count,
ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary

FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
job_title_short = 'Data Analyst'
AND salary_year_avg IS NOT NULL
AND job_work_from_home = 'True'

GROUP BY
skills_dim.skill_id

HAVING
COUNT(skills_job_dim.job_id) > 10

ORDER BY
demand_count DESC,
avg_salary DESC

LIMIT 25;

/*
Here's the breakdown of optimal skills combining high demand and high salary:
Highest Demand: SQL is the most requested skill overall with 398 job offers, followed by Excel (256) and Python (236).
Top Pay in High Demand: Among the top 5 most demanded skills, Python ($101,397) and R ($100,499) break the six-figure annual salary threshold.
Visualization Tools: While Tableau heavily outperforms Power BI in job volume (230 vs 110 listings—more than 2x the demand), both command similar average salary ranges (~$97k to $99k).
High-Paying Niche Skills: Specialized tools sitting outside the top 10 most demanded—such as Go ($115,320), Hadoop ($113,193), Snowflake ($112,948), and Azure ($111,225)—command significantly higher average salaries due to their technical complexity.
*/


/*rewritten query, avoiding SAS duplicates*/

SELECT
REPLACE(LOWER(skills_dim.skills),' ','') AS skills_name,
COUNT(skills_job_dim.job_id) AS demand_count,
ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary


FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id =skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
job_title_short = 'Data Analyst'
AND job_work_from_home = 'True'
AND salary_year_avg IS NOT NULL

GROUP BY
REPLACE(LOWER(skills_dim.skills),' ','')

HAVING
count(skills_job_dim.job_id) > 10

ORDER BY
demand_count DESC,
avg_salary DESC

LIMIT 25;

/*
Data Quality & Refactoring Methodology
Why I Rewrote the SQL Query: An audit of the underlying skills_dim dimension table revealed systemic entity duplication across the database. Normalizing text strings (using LOWER() and REPLACE() to handle formatting inconsistencies and spaces) uncovered that several key technologies—including powerbi, sqlserver, asp.netcore, sas, mongodb, firebase, ruby, and others—were registered across multiple distinct primary keys (skill_id), with some fragmented into as many as three separate entries.
The Issue: Grouping strictly by skill_id split market metrics across duplicate keys, severely underrepresenting true job demand and compensation for affected tools (for instance, fracturing Power BI across IDs 183, 203, and 205).
The Solution: To accurately aggregate market demand, I refactored the query to group by LOWER(REPLACE(skills_dim.skills, ' ', '')). While grouping by a non-primary key text column is traditionally discouraged in database design, it was the essential engineering workaround required here to resolve systemic entity duplication and uncover true market standings.
The Impact:
Consolidated duplicate and space-fragmented skill records across the dataset into accurate, unified market totals.
Elevated SAS to its true position (#6 overall with 126 job mentions and a $98,902 average salary).
Restored ranking integrity, ensuring that top-tier demand metrics reflect absolute reality rather than artifacts of flawed data entry.
*/