# Introduction
Welcome to my **Data Analyst Job Market Analysis** project! This project explores the job market for remote Data Analysts to uncover top-paying roles, highly requested skills, and the most optimal technologies that balance high market demand with lucrative salaries.

By analyzing real-world job posting data, this project provides data-backed insights for aspiring data professionals navigating career paths and targeting high-value technical skills.

All modular SQL queries used for this project are organized in the [project_sql folder](/sql_load-20260614T134302Z-3-001/project_sql/)

# Background
The modern tech job market is vast and rapidly evolving. For aspiring analysts and career switchers, determining which technical skills offer the best return on investment (ROI) can be challenging.

#### Key Questions Addressed:
1. What are the top-paying Data Analyst jobs?
2. What skills are required for these top-paying roles?
3. What are the most in-demand skills for Data Analysts overall?
4. Which skills command the highest average salaries?
5. What are the **most optimal skills** to learn (high demand + high salary)?

# Tools I Used
To tackle this analysis, I leveraged key tools in the modern data stack:

* **SQL (PostgreSQL):** Used for database querying, data filtering, aggregations, and multi-table joins using Common Table Expressions (CTEs).

* **Visual Studio Code:** Integrated Development Environment (IDE) used for writing, editing, and executing SQL scripts.

* **Git & GitHub:** Version control system used for tracking query updates, committing code changes, and publishing project documentation.

* **pgAdmin 4:** Relational database management UI used for database schema setup and data verification.

# The Analysis
### 1. Top Paying Data Analyst Jobs
Identifies the top 10 highest-paying remote Data Analyst positions available in the dataset.
```SQL 

        SELECT
        job_id,
        job_title,
        salary_year_avg,
        job_location,
        job_schedule_type,
        job_posted_date,
        name AS company_name

        FROM
        job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

        WHERE
        job_title_short LIKE 'Data Analyst' AND
        job_location = 'Anywhere'  AND
        salary_year_avg IS NOT NULL

        ORDER BY
        salary_year_avg DESC

        LIMIT 10;
```

Here's the breakdown of the top-paying Data Analyst roles in the dataset:

* **Salary Range:** Annual compensation across the top 10 roles ranges from $184,000 to $650,000.

* **Top Earners:** Data Analyst at Mantys commands the highest annual salary at $650,000, followed by Director of Analytics at Meta at $336,500.

* **Prominent Employers:** Major enterprise listings include AT&T ($255,830), Pinterest ($232,423), UCLA Health ($217,000), and SmartAsset ($205,000).

* **Seniority Premium:** Leadership and principal titles (e.g., Director, Associate Director, and Principal Analyst) represent the majority of high-compensation opportunities.



![Top Paying Data Analyst Jobs](/sql_load-20260614T134302Z-3-001/project_sql/Assets/1_top_paying_jobs.png)


### 2. Skills Required for Top Paying Jobs
Analyzes which specific technical skills are required across the top 10 highest-paying Data Analyst roles.  
```SQL 

        WITH top_paying_job_skills AS
        (
            SELECT
            job_id,
            job_title,
            salary_year_avg,
            name AS company_name
            FEOM
            job_postings_fact
            LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
            WHERE
            job_title_short LIKE 'Data Analyst' AND
            job_location = 'Anywhere'  AND
            salary_year_avg IS NOT NULL
            ORDER BY
            salary_year_avg DESC
            LIMIT 10
        )
        SELECT 
        top_paying_job_skills.*,
        skills
        FROM top_paying_job_skills
        INNER JOIN skills_job_dim ON top_paying_job_skills.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        ORDER by 
        salary_year_avg DESC;
```
Here's the breakdown of the skills required for the top-paying Data Analyst roles:

* **The Big Three Foundation:** **SQL** (8 postings), **Python** (7 postings), and **Tableau** (6 postings) are the most frequently requested skills among top-earning job descriptions.
* **Data Science & Analytics Tools:** **R**, **Pandas**, and **Snowflake** follow closely, proving that analytical libraries and cloud data warehousing are key drivers in high-paying roles.
* **Cloud & Collaboration Tech:** Cloud platforms (**AWS**, **Azure**) and developer collaboration tools (**GitLab**, **Jira**, **Bitbucket**) appear regularly across top-tier listings, averaging salaries between $189k and $222k.



![Top Paying Job Skills](/sql_load-20260614T134302Z-3-001/project_sql/Assets/2_top_paying_job_skills.png)



### 3. Most In-Demand Skills for Data Analysts
Identifies the top 5 most frequently requested skills across all remote Data Analyst job postings.
```SQL

        SELECT
        skills,
        count(skills_job_dim.job_id) as demand_count
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
        LIMIT 5;
```
Here's the breakdown of the most in-demand skills overall:

* **SQL Dominance:** SQL leads with 7,291 job mentions, outpacing the second most demanded skill by over 58%. It remains the single most critical technical skill for landing a data analyst role.

* **Core Foundation Pair:** SQL and Excel together represent over 52% of total demand among the top 5 skills, proving that data querying and spreadsheet processing form the baseline requirement for most positions.

* **Programming vs. Visualization:** Python (4,330 mentions) slightly edges out Tableau (3,745 mentions), reflecting a high employer demand for programmatic data handling alongside dashboarding capabilities.

* **BI Tool Split:** Tableau leads Power BI by 1,136 postings (a 43.5% lead in demand), though both remain essential enterprise visualization standards.


| Rank | Skill | Demand Count |
| :---: | :--- | :---: |
| **1** | **SQL** | **7,291** |
| **2** | **Excel** | **4,611** |
| **3** | **Python** | **4,330** |
| **4** | **Tableau** | **3,745** |
| **5** | **Power BI** | **2,609** |



### 4. Top Paying Skills Based on Salary
Examines the highest average salaries associated with specific technical skills.

```SQL
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
    LIMIT 25;
```
Here's the breakdown of skills associated with the highest average salaries:

* **Big Data Leads the Market:** PySpark stands out as the only skill exceeding $200,000 annually, highlighting the premium employers place on distributed computing expertise.

* **DevOps & Engineering Integration:** Skills like Bitbucket ($189,155), GitLab ($154,500), and Kubernetes ($132,500) show that data analysts who adopt software engineering and CI/CD practices command significantly higher compensation.

* **Python Ecosystem Dominance:** Core Python stack tools—Jupyter ($152,777) and Pandas ($151,821)—consistently rank among the top-paying technical skills, demonstrating high employer demand for programmatic data handling.

* **AutoML & Cloud AI Premium:** Platform-level machine learning tools such as Watson ($160,515) and DataRobot ($155,486) bridge the gap between business analysis and predictive AI engineering.


| Rank | Skill | Average Annual Salary |
| :---: | :--- | :---: |
| **1** | **pyspark** | **$208,172** |
| **2** | **bitbucket** | **$189,155** |
| **3** | **couchbase** | **$160,515** |
| **4** | **watson** | **$160,515** |
| **5** | **datarobot** | **$155,486** |
| **6** | **gitlab** | **$154,500** |
| **7** | **swift** | **$153,750** |
| **8** | **jupyter** | **$152,777** |
| **9** | **pandas** | **$151,821** |
| **10** | **elasticsearch** | **$145,000** |


### 5. Most Optimal Skills to Learn (Demand + Salary)
Combines demand count and average salary using CTEs to highlight skills that offer high job security and strong compensation.

```SQL
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
            avg_salary DESC,
            demand_count DESC

            LIMIT 25;

/*rewritten query, shorter version*/

    SELECT
    skills_dim.skill_id,
    skills,
    COUNT(skills_dim.skill_id) AS demand_count,
    ROUND(AVG(salary_year_avg),0) AS avg_salary

    FROM job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id =skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

    WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = 'True'
    AND salary_year_avg IS NOT NULL

    GROUP BY
    skills_dim.skill_id

    HAVING
    COUNT(skills_dim.skill_id) > 10
    ORDER BY
    avg_salary DESC,
    demand_count DESC;

/*rewritten query, avoiding SAS duplicates*/

    SELECT
    LOWER(skills_dim.skills) as skills_name,
    COUNT(skills_job_dim.job_id) as demand_count,
    ROUND(AVG(salary_year_avg),0) as avg_salary

    FROM job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

    WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = 'True'
    AND salary_year_avg IS NOT NULL

    GROUP BY
    LOWER(skills_dim.skills)

    HAVING
    COUNT(skills_job_dim.job_id) > 10

    ORDER BY
    demand_count DESC,
    avg_salary DESC

    LIMIT 25
```
Here's the breakdown of optimal skills combining high demand and high salary:

* **Highest Demand:** SQL is the most requested skill overall with 398 job offers, followed by Excel (256) and Python (236).

* **Top Pay in High Demand:** Among the top 5 most demanded skills, Python ($101,397) and R ($100,499) break the six-figure annual salary threshold.

* **Visualization Tools:** While Tableau heavily outperforms Power BI in job volume (230 vs 110 listings—more than 2x the demand), both command similar average salary ranges (~$97k to $99k).

* **High-Paying Niche Skills:** Specialized tools sitting outside the top 10 most demanded—such as Go ($115,320), Hadoop ($113,193), Snowflake ($112,948), and Azure ($111,225)—command significantly higher average salaries due to their technical complexity.


### Original version, grouped by skill_ID

| Skill ID | Skill Name | Demand Count | Average Salary |
| :---: | :--- | :---: | :---: |
| 0 | sql | 398 | $97,237 |
| 181 | excel | 256 | $87,288 |
| 1 | python | 236 | $101,397 |
| 182 | tableau | 230 | $99,288 |
| 5 | r | 148 | $100,499 |
| 184 | power bi | 110 | $97,431 |
| 7 | sas | 63 | $98,902 |
| 186 | sas | 63 | $98,902 |
| 185 | powerpoint | 58 | $88,701 |
| 183 | looker | 49 | $103,795 |


#### Data Quality & Refactoring Methodology

**Why I Rewrote the SQL Query:**
An audit of the underlying `skills_dim` dimension table revealed systemic entity duplication across the database. Several technologies—including **powerbi**, **mongodb**, **firebase**, **ruby**, **sqlserver**, **asp.netcore**, and **sas**—were registered under multiple distinct primary keys (`skill_id`).

* **The Issue:** Grouping by skill_id split metrics across multiple distinct IDs for the same skill name, underrepresenting true job demand for affected tools (for instance, splitting SAS across `skill_id 7` and `skill_id 186`).
* **The Solution:** To accurately aggregate market demand, I refactored the query to group by `LOWER(skills_dim.skills)`. *While grouping by a non-primary key text column is generally not database best practice, it was the necessary engineering approach here to resolve entity duplication and expose the true optimal skills.*
* **The Impact:**
  1. Consolidated duplicate skill records across the dataset into accurate, unified market totals.
  2. Elevated **SAS** to its true position (#6 overall with 126 job mentions and a $98,902 average salary).
  3. Restored ranking integrity, allowing previously obscured high-demand tools like **Looker** and **MS Word** to properly surface in the Top 10 list.


### Rewritten version result, grouped by skills (avoiding duplicates)

| Skill Name | Demand Count | Average Salary |
| :--- | :---: | :---: |
| sql | 398 | $97,237 |
| excel | 256 | $87,288 |
| python | 236 | $101,397 |
| tableau | 230 | $99,288 |
| r | 148 | $100,499 |
| sas | 126 | $98,902 |
| power bi | 110 | $97,431 |
| powerpoint | 58 | $88,701 |
| looker | 49 | $103,795 |
| word | 48 | $82,576 |

### 🔍 Data Hygiene & Schema Audit

Before executing the final analysis, I conducted a data quality audit using a Common Table Expression (CTE) to check for entity redundancy and schema issues in the `skills_dim` table.

```sql
With skilltable AS 
(SELECT
skills,
COUNT(skills) AS count

FROM 
skills_dim
GROUP BY
skills
HAVING
COUNT(skills) > 1)

Select
skill_ID,
skilltable.skills

FROM skilltable
INNER JOIN skills_dim ON skilltable.skills = skills_dim.skills
```
The following table lists the skill names that have duplicate entries under different primary keys (skill_id) in the database. The audit identified a total of 7 distinct skills that have duplicate entries across 14 rows in the database:

| Skill ID | Skill Name |
| :---: | :--- |
| 7 | sas |
| 18 | mongodb |
| 30 | ruby |
| 62 | mongodb |
| 66 | firebase |
| 71 | sqlserver |
| 77 | sqlserver |
| 82 | firebase |
| 144 | ruby |
| 164 | asp.netcore |
| 166 | asp.netcore |
| 186 | sas |
| 203 | powerbi |
| 205 | powerbi |


# What I Learned

Through executing this project, I strengthened my core data analytics, data hygiene, and SQL query optimization competencies:

* **Advanced SQL & Data Cleansing:** Written complex aggregation queries using `GROUP BY`, aggregate functions (`AVG()`, `COUNT()`), and string normalization (`LOWER()`) to handle data hygiene issues and prevent entity duplication.
* **Data Auditing & Quality Control:** Conducted schema audits using Common Table Expressions (CTEs) to detect duplicate entity records in dimension tables, ensuring metric integrity and accurate business intelligence.
* **CTE Modularization:** Built structured, multi-step temporary tables using `WITH` clauses to maintain clean, readable, and well-organized query pipelines.
* **Database Modeling & Relational Joins:** Connected fact (`job_postings_fact`) and dimension (`skills_dim`) tables across `INNER JOIN` and `LEFT JOIN` relationships using star schema principles.
* **Developer Workflow:** Managed source code and version control using Git and VS Code, while documenting trade-offs, schema anomalies, and analytical takeaways in Markdown on GitHub.
# Conclusions

### Insights

1. **Top-Paying Data Analyst Jobs:** Remote Data Analyst positions offer a wide spectrum of compensation, with top-tier roles reaching up to $650,000 for specialized leadership and technical positions.

2. **Skills for Top-Paying Jobs:** **SQL is the #1 most requested skill** among top-paying data analyst roles (8 mentions), followed by **Python** (7 mentions), **Tableau** (6 mentions), **R** (4 mentions), and **Snowflake**,**Excel**,**Pandas** are tie at (3 mentions). This proves that even for high-salary positions, strong SQL expertise remains the primary technical requirement alongside programming and cloud data platforms.

3. **Most In-Demand Skills:** Core data tools like **SQL** (7,291 total mentions) and **Excel** (4,611 total mentions) dominate overall job posting volume, proving that relational database querying and spreadsheet processing remain the foundational baseline requirements for remote analysts.

4. **Skills with Higher Salaries:** Niche technical expertise commands the highest average compensation, with specialized technologies and data engineering tools (e.g., **PySpark**, **Bitbucket**, **Couchbase**, **Watson**, **DataRobot**) yielding premium pay due to low market supply.

5. **Optimal Skills for Job Market Value:** **SQL** and **Excel** emerge as the most optimal skills to learn. SQL leads all skills with 398 high-paying job mentions and an average salary of $97,237, followed closely by Excel with 256 mentions ($87,288). Together with **Python** (236 mentions, $101,397), these core tools offer the best balance of job market demand, security, and strong financial return.

### Closing Thoughts

Working through this project was a huge milestone in my journey as an aspiring data analyst. Beyond practicing foundational SQL concepts like multi-table joins, CTEs, and aggregation, it taught me the importance of critical thinking and data hygiene. 

When I noticed entity duplication in the dataset (such as SAS, Power BI, and MongoDB split across multiple primary keys), I learned firsthand that running queries isn't just about getting code to execute—it's about ensuring the underlying data delivers accurate business truth. Resolving these edge cases to reveal the genuine Top 10 optimal skills gave me real confidence in my ability to audit datasets, troubleshoot unexpected results, and communicate data-driven insights effectively.