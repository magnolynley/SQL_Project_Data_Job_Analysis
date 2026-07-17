select 
j.job_id as jobID,
s.skill_id as skillID,
k.skills as skillNAME
FROM january_jobs as j
 left join skills_job_dim as s on j.job_id = s.job_id
 left join skills_dim as k on s.skill_id = k.skill_id
where 
salary_year_avg > 70000

UNION ALL

select 
f.job_id as jobID,
s.skill_id as skillID,
k.skills as skillNAME
FROM february_jobs as f
 left join skills_job_dim as s on f.job_id = s.job_id
 left join skills_dim as k on s.skill_id = k.skill_id
where 
salary_year_avg > 70000

 UNION ALL

 select 
m.job_id as jobID,
s.skill_id as skillID,
k.skills as skillNAME
FROM march_jobs as m
 left join skills_job_dim as s on m.job_id = s.job_id
 left join skills_dim as k on s.skill_id = k.skill_id
 where 
salary_year_avg > 70000