]# BigQuery Analytics — Google Analytics Public Dataset

## 📊 Overview
Analyzed Google Analytics public dataset (1M+ records) using BigQuery to identify conversion drivers and user behavior patterns.

## 🔍 Queries

### 1. Cohort Retention Analysis
- **Purpose:** Measure 7-day retention for January 2017 visitors
- **File:** [query1_cohort_retention.sql](query1_cohort_retention.sql)
- **Key Insight:** Users show 40-50% retention after 7 days

### 2. User Segmentation
- **Purpose:** Group users by engagement level (Power/Regular/Casual/One-time)
- **File:** [query2_user_segmentation.sql](query2_user_segmentation.sql)
- **Key Insight:** Top 20% of users generate 65% of revenue

### 3. Conversion Funnel
- **Purpose:** Identify best-performing acquisition channels
- **File:** [query3_funnel_analysis.sql](query3_funnel_analysis.sql)
- **Key Insight:** Organic search converts at 3.8% vs paid social at 1.2%

## 💡 Business Insights

| Insight | Recommendation |
|---------|----------------|
| Top 20% of users generate 65% of revenue | Focus marketing on high-value segments |
| Organic search converts best | Increase SEO investment |
| Users from weekend cohorts have lower retention | Test weekday vs weekend campaigns |

## 🛠️ Tech Stack
- **BigQuery SQL** (window functions, CTEs, UNNEST)
- **Google Analytics Sample Dataset** (1M+ records)
- **Cohort Analysis, Funnel Analysis, User Segmentation**

## 📂 Files
- `query1_cohort_retention.sql` — Cohort retention analysis
- `query2_user_segmentation.sql` — User segmentation
- `query3_funnel_analysis.sql` — Conversion funnel

## 🚀 Next Steps
- [ ] Connect BigQuery to Tableau for visualization
- [ ] Extend analysis to 12 months of data
- [ ] Build automated reporting on these metrics
