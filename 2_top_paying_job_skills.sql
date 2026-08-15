

SELECT salary_year_avg, job_title, job_id,job_posted_date, job_schedule_type, job_location,name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL AND job_location = 'India'
ORDER BY salary_year_avg DESC
LIMIT 10