-- QUERY 1: COHORT RETENTION ANALYSIS
WITH first_visit AS (
  SELECT 
    fullVisitorId,
    MIN(PARSE_DATE('%Y%m%d', date)) AS first_visit_date
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20170131'
  GROUP BY fullVisitorId
),

retention_check AS (
  SELECT 
    f.fullVisitorId,
    f.first_visit_date,
    COUNT(DISTINCT s.date) AS return_visits_7day
  FROM first_visit f
  LEFT JOIN `bigquery-public-data.google_analytics_sample.ga_sessions_*` s
    ON f.fullVisitorId = s.fullVisitorId
    AND PARSE_DATE('%Y%m%d', s.date) > f.first_visit_date
    AND PARSE_DATE('%Y%m%d', s.date) <= f.first_visit_date + 7
  WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20170131'
  GROUP BY f.fullVisitorId, f.first_visit_date
)

SELECT 
  first_visit_date,
  COUNT(DISTINCT fullVisitorId) AS cohort_size,
  SUM(CASE WHEN return_visits_7day > 0 THEN 1 ELSE 0 END) AS retained_users,
  ROUND(
    (SUM(CASE WHEN return_visits_7day > 0 THEN 1 ELSE 0 END) * 100.0) / 
    COUNT(DISTINCT fullVisitorId), 
    2
  ) AS retention_rate_pct
FROM retention_check
GROUP BY first_visit_date
ORDER BY first_visit_date;
