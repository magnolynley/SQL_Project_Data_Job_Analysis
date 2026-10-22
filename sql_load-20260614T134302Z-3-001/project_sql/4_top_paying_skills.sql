/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? it reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
skills,
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
skills

ORDER BY
avg_salary DESC

LIMIT 25

/*
Here's the breakdown of skills associated with the highest average salaries:
Big Data Leads the Market: PySpark stands out as the only skill exceeding $200,000 annually, highlighting the premium employers place on distributed computing expertise.
DevOps & Version Control Integration: Tools like Bitbucket ($189,155) and GitLab ($154,500) demonstrate that data professionals who adopt software engineering and CI/CD pipelines command significantly higher compensation.
Data Management & Cloud AI Premium: Architectural platforms such as Couchbase ($160,515) alongside AI/ML tools like Watson ($160,515) and DataRobot ($155,486) bridge the gap between heavy data storage, business analysis, and predictive engineering.
Python Ecosystem & Application Development: Core tech stack tools—including Swift ($153,750), Jupyter ($152,777), and Pandas ($151,821)—consistently rank among the top-paying technical skills, demonstrating high employer demand for programmatic data handling and mobile development integration.
Enterprise Search & Analytics: Elasticsearch ($145,000) rounds out the top 10, emphasizing the value of real-time search and log analytics capabilities in high-paying roles.
*/