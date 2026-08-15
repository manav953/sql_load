
SELECT salary_year_avg, job_title, job_id,job_posted_date, job_schedule_type, job_location
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL AND job_work_from_home = 'Yes'
ORDER BY salary_year_avg DESC
LIMIT 10