

WITH top10_jobs AS (
SELECT salary_year_avg, job_title, job_id,job_posted_date, job_schedule_type, job_location,name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL AND job_location = 'India'
ORDER BY salary_year_avg DESC
LIMIT 10
)
SELECT top10_jobs.*,skills
FROM top10_jobs
INNER JOIN skills_job_dim ON top10_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC