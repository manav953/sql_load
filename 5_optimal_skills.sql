WITH skills_demand AS (
    SELECT 
        skill_id,
        COUNT(job_postings_fact.job_id) AS demand
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE job_title_short = 'Data Analyst' 
        AND job_location = 'India' 
        AND salary_year_avg IS NOT NULL 
    GROUP BY skill_id
),

average_salary AS (
    SELECT 
        skill_id,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE job_title_short = 'Data Analyst' 
        AND job_location = 'India' 
        AND salary_year_avg IS NOT NULL 
    GROUP BY skill_id
)

SELECT
    skills_dim.skills,
    skills_demand.demand,
    average_salary.avg_salary
FROM skills_demand
INNER JOIN average_salary 
    ON skills_demand.skill_id = average_salary.skill_id
INNER JOIN skills_dim
    ON skills_demand.skill_id = skills_dim.skill_id
ORDER BY skills_demand.demand DESC,
         avg_salary DESC;



SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary

FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'India'
GROUP BY skills_dim.skill_id
--HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY avg_salary DESC,demand_count DESC
LIMIT 25;

        
