SELECT
jobtitle,
count (*)
FROM (
SELECT
job_title_short as jobtitle,
count(*),
job_location,
salary_year_avg

FROM
job_postings_fact

WHERE
job_title_short not like '%Senior%'
and job_location = 'Anywhere'
and salary_year_avg > 90000

group by 
job_location, 
salary_year_avg,
job_title_short

order by 
salary_year_avg DESC

) as subquerytable
group by
jobtitle

ORDER BY
count (*) DESC
limit 5