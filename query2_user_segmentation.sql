-- QUERY 2: USER SEGMENTATION
WITH user_metrics AS (
  SELECT 
    fullVisitorId,
    SUM(totals.pageviews) AS total_pageviews,
    COUNT(DISTINCT CONCAT(visitId, fullVisitorId)) AS total_sessions,
    SUM(totals.transactions) AS total_transactions,
    SUM(totals.transactionRevenue) / 1000000 AS total_revenue_usd
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20171231'
  GROUP BY fullVisitorId
)

SELECT 
  CASE 
    WHEN total_pageviews > 50 AND total_sessions > 10 THEN 'Power User'
    WHEN total_pageviews > 20 AND total_sessions > 5 THEN 'Regular User'
    WHEN total_pageviews > 5 AND total_sessions > 1 THEN 'Casual User'
    ELSE 'One-time Visitor'
  END AS user_segment,
  COUNT(DISTINCT fullVisitorId) AS user_count,
  ROUND(AVG(total_pageviews), 2) AS avg_pageviews,
  ROUND(AVG(total_sessions), 2) AS avg_sessions,
  SUM(total_transactions) AS total_transactions,
  ROUND(SUM(total_revenue_usd), 2) AS total_revenue_usd,
  ROUND(
    (COUNT(DISTINCT fullVisitorId) * 100.0) / 
    (SELECT COUNT(DISTINCT fullVisitorId) FROM user_metrics),
    2
  ) AS pct_of_total
FROM user_metrics
GROUP BY user_segment
ORDER BY avg_pageviews DESC;
