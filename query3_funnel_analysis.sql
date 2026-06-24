-- QUERY 3: CONVERSION FUNNEL ANALYSIS
SELECT 
  trafficSource.source AS traffic_source,
  COUNT(DISTINCT fullVisitorId) AS total_visitors,
  COUNT(DISTINCT CASE WHEN totals.pageviews > 0 THEN fullVisitorId END) AS viewed_landing,
  COUNT(DISTINCT CASE WHEN totals.transactions > 0 THEN fullVisitorId END) AS made_purchase,
  ROUND(
    COUNT(DISTINCT CASE WHEN totals.transactions > 0 THEN fullVisitorId END) * 100.0 / 
    COUNT(DISTINCT fullVisitorId), 2
  ) AS conversion_rate
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20171231'
GROUP BY trafficSource.source
HAVING total_visitors > 100
ORDER BY conversion_rate DESC;
