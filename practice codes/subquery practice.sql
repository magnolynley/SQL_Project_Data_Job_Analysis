SELECT
 name as companyNAME,
 countID

FROM
company_dim

inner join (

SELECT
company_id,
count(*) as countID
FROM
job_postings_fact

group BY
company_id

having count(*) > 50


) as IDtable on company_dim.company_id = IDtable.company_id

WHERE
name not like '%Group%'

order BY
countID desc

