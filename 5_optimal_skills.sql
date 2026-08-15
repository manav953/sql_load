
WITH skills_demand AS (
    SELECT 
       COUNT(skills_job_dim.job_id) AS demand
       ,skills_job_dim.skill_id
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' AND job_location ='India' AND salary_year_avg IS NOT NULL 
    GROUP BY skills_job_dim.skill_id,skills
    ORDER BY demand DESC
    
),average_salary AS (
    SELECT 
    ROUND(AVG(salary_year_avg), 2) AS avg_salary,skills_job_dim.skill_id
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' AND job_location ='India' AND salary_year_avg IS NOT NULL 
    GROUP BY skills_job_dim.skill_id,skills
    ORDER BY avg_salary DESC
    
)
 
SELECT
    skills_demand.skill_id,
    skills_demand.skill,
    demand,
    average_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
