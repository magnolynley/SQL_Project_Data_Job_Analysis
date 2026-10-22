 /*
 Question: How can we identify and audit duplicate skill names in the dataset to ensure data integrity?
  - Objective: Use a CTE with GROUP BY and HAVING to find skills that appear more than once in the skills_dim table.
  - Why?: Resolves data anomalies (e.g., duplicate entity records) to ensure accurate analysis and reliable job market metrics.
 */

WITH skilltable AS 
    (   
        SELECT
        REPLACE(LOWER(skills),' ','') as skills,
        COUNT(skills) AS count

        FROM 
        skills_dim

        GROUP BY
        REPLACE(LOWER(skills),' ','')

        HAVING
        COUNT(skills) > 1
    )


    SELECT
    skill_ID,
    skilltable.skills

    FROM skilltable
    INNER JOIN skills_dim ON skilltable.skills = REPLACE(LOWER(skills_dim.skills),' ','')

/*
The following table lists the comprehensive results of a database schema audit. By normalizing the text strings (using LOWER() and REPLACE() to strip spaces and formatting inconsistencies), the audit revealed deeper data hygiene anomalies across the dimension table.
Specifically, several key technologies (such as 'powerbi', 'sqlserver', and 'asp.netcore') were fragmented across two or more distinct primary keys (skill_id) stemming from duplicate skill names. Uncovering these hidden redundancies ensured that market demand metrics were accurately consolidated rather than artificially split or underrepresented.
*/