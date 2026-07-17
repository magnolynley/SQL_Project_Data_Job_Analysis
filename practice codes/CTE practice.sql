
with companytable AS (

Select company_id,
count(*) as companyID
From
job_postings_fact

group BY
company_id
)

select name as companyNAME,
companyID,

case
when companyID < 10 then 'Small'
when companyID between 10 and 50 then 'Medium'
when companyID > 50 then 'Large'
end as companySIZE

from company_dim

left join companytable on company_dim.company_id = companytable.company_id


limit 1000

