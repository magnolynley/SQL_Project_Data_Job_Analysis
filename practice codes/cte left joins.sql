with companytable AS
(SELECT
c.name as companyname,
s.skills as skillname,
count(j.job_id) as jobcount

FROM
skills_dim as s

left join skills_job_dim as k on s.skill_id=k.skill_id
left join job_postings_fact as j on k.job_id=j.job_id
left join company_dim as c on j.company_id=c.company_id

WHERE
skills in ('tableau', 'power bi')
and salary_year_avg is not null
group BY
c.name,
s.skills)

SELECT
skillname,
round(avg(jobcount), 2) as avgjob,
count(companyname) as companycount

FROM
companytable
group by 
skillname
order BY
avg(jobcount) desc
