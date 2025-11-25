# 🛍️ **ShopEasy Marketing Analytics — End-to-End Data Analysis Project**
### **SQL Server | Python (NLTK Sentiment Analysis) | Power BI | Data Modeling | Dashboarding**

A complete **end-to-end analytics project** that demonstrates skills across **SQL**, **Python**, **NLP**, **Power BI**, and **business storytelling**.  
This project analyzes why ShopEasy is experiencing declining engagement, conversion rates, and mixed customer satisfaction—and provides actionable, data-backed recommendations.

---

## 📑 **Table of Contents**
- <a href="#overview"><b>Overview</b></a>
- <a href="#executive-summary"><b>Executive Summary</b></a>
- <a href="#business-problem"><b>Business Problem</b></a>
- <a href="#goals"><b>Goals</b></a>
- <a href="#tools-technologies"><b>Tools & Technologies</b></a>
- <a href="#project-flow"><b>End-to-End Project Flow</b></a>
- <a href="#sql"><b>MSSQL: Data Preparation</b></a>
- <a href="#python"><b>Python: Sentiment Analysis</b></a>
- <a href="#powerbi"><b>Power BI: Modeling & Dashboards</b></a>
- <a href="#key-insights"><b>Key Insights</b></a>
- <a href="#recommendations"><b>Recommended Actions</b></a>
- <a href="#project-structure"><b>Project Structure</b></a>
- <a href="#run"><b>How to Run This Project</b></a>
- <a href="#author"><b>Author & Contact</b></a>

---

# <h2 id="overview">📌 **Overview**</h2>

This project uncovers performance issues across **customer engagement**, **conversion patterns**, **product satisfaction**, and **marketing effectiveness** for ShopEasy.  
It leverages:

- **SQL Server** for data cleaning & transformation  
- **Python (NLTK)** for sentiment analysis  
- **Power BI** for dashboard creation  

The outcome is a complete, actionable analytics solution to improve performance and marketing ROI.

---

# <h2 id="executive-summary">📘 **Executive Summary**</h2>

**(As provided — unchanged)**

ShopEasy, an online retail business, is experiencing a decline in customer engagement and conversion rates despite increased investment in marketing campaigns. This analysis aims to leverage existing customer and engagement data to identify the root causes, provide actionable insights, and ultimately improve the marketing strategy, boost conversion rates, enhance customer engagement, and improve customer feedback scores.

---

# <h2 id="business-problem">❗ **Business Problem**</h2>

**(As provided — unchanged)**

ShopEasy is facing several key challenges that necessitate a data-driven approach to their marketing strategy:  
• **Reduced Customer Engagement:** The number of customer interactions with the website and marketing content has declined.  
• **Decreased Conversion Rates:** Fewer site visitors are successfully converting into paying customers.  
• **High Marketing Expenses:** Significant investments in marketing campaigns are not yielding the expected Return on Investment (ROI).  
• **Need for Customer Feedback Analysis:** Understanding customer opinions about products and services is crucial for improving engagement and conversions.

---

# <h2 id="goals">🎯 **Goals**</h2>

**(As provided — unchanged)**

1. **Increase Conversion Rates:** Identify factors impacting the conversion rate and provide recommendations for improvement.  
2. **Enhance Customer Engagement:** Determine which types of content drive the highest engagement.  
3. **Improve Customer Feedback Scores:** Understand common themes and sentiment in customer reviews and provide actionable insights.

---

# <h2 id="tools-technologies">🛠 **Tools & Technologies**</h2>

| **Tool** | **Purpose** |
|---------|-------------|
| **Microsoft SQL Server** | Data extraction, cleaning, transformation, analysis |
| **Python (Pandas, NLTK, SQLAlchemy)** | Sentiment analysis, SQL querying, data enrichment |
| **Power BI** | Data modeling, dashboard creation, visual insights |
| **SQLAlchemy + PyODBC** | Python ↔ SQL Server integration |
| **NLTK VADER** | Sentiment classification (Positive, Mixed, Negative) |

---

# <h2 id="project-flow">🔄 **End-to-End Project Flow**</h2>

MSSQL → Data Cleaning & Standardization
↓
Python Sentiment Analysis → CSV Export
↓
Power BI → Data Modeling → DAX → Dashboards
↓
Insights → Recommendations


This flow demonstrates a full analytics lifecycle—from raw data to business-ready dashboards.

---

# <h2 id="sql">🗄️ **MSSQL: Data Preparation & Analysis**</h2>

### ✔ **Database Creation**
- Restored `MarketingAnalytics.bak` into SQL Server  
- Database name: **PortfolioProject_MarketingAnalytics**

### ✔ **Data Cleaning & Transformations**
- **Products:** Added price categories using `CASE`  
- **Customers:** Joined with Geography table  
- **Customer Reviews:** Cleaned text formatting  
- **Engagement Data:** Split Views–Clicks field, standardized content types  
- **Customer Journey:** Removed duplicates with `ROW_NUMBER()` and filled null durations  

### ✔ **SQL Features Demonstrated**
- Window functions  
- CTEs  
- Joins  
- Aggregations  
- Conditional logic  
- Date formatting  

📄 All SQL scripts stored in: **queries.sql**

---

# <h2 id="python">🐍 **Python: Sentiment Analysis**</h2>

### ✔ **Purpose**
To understand customer sentiment more deeply than numeric ratings allow—helping identify hidden pain points and satisfaction drivers.

### ✔ **What the Script Does**
- Connects to SQL Server using SQLAlchemy  
- Loads raw customer reviews  
- Applies **VADER sentiment scoring**  
- Creates three new sentiment fields:  
  - **SentimentScore** (numeric score)  
  - **SentimentCategory** (Positive, Negative, Mixed Positive, Mixed Negative, Neutral)  
  - **SentimentBucket** (score range groups)  
- Exports enriched data to CSV

### ✔ **Output File**
📄 `fact_customer_reviews_with_sentiment.csv`

---

# <h2 id="powerbi">📊 **Power BI: Data Modeling & Dashboarding**</h2>

### ✔ **Data Connections**
- Direct SQL Server import  
- Sentiment CSV from Python  

### ✔ **Data Model (Star Schema)**

**Dimensions:**
- `dim_products`  
- `dim_customers`  
- `Calendar`  

**Fact Tables:**
- `fact_customer_reviews`  
- `fact_customer_reviews_sentiment`  
- `fact_engagement_data`  
- `fact_customer_journey`  

### ✔ **Calendar Table**
Created to enable time intelligence (Month, Quarter, Year, etc.)

### ✔ **DAX Measures**
```DAX
Views = SUM(fact_engagement_data[Views])
Clicks = SUM(fact_engagement_data[Clicks])
Likes = SUM(fact_engagement_data[Likes])
Rating (Average) = AVERAGE(fact_customer_reviews[Rating])
Number of Journeys = COUNT(fact_customer_journey[JourneyID])
Conversion Rate = DIVIDE([Clicks], [Views], 0)


✔ Dashboard Pages

Overview Dashboard

Conversion Performance

Social Media Engagement

Customer Reviews & Sentiment

<h2 id="key-insights">🔍 Key Insights</h2>
🟦 Conversion Trends

Average conversion rate: 9.57%

Worst month: October (6.15%)

Best month: January (17.31%)

Strong seasonal impact

🟧 Engagement Trends

Views declined consistently after April

Likes remained near zero → poor interaction quality

Blogs performed best among all content types

🟩 Customer Feedback

Average rating: 3.69

Sentiment breakdown:

Positive: 840

Negative: 226

Mixed Negative: 196

Mixed Positive: 86

Neutral: 15

<h2 id="recommendations">📌 Recommended Actions</h2>
✔ Boost Conversion

Focus on high-performing products (Ski Boots, Hockey Stick, Baseball Glove)

Launch seasonal promotions Jan–Feb and Dec

Improve mid-year performance (Mar–Jun) with targeted campaigns

✔ Improve Engagement

Refresh content strategy (interactive posts, reels, CTAs)

Increase posting frequency Jul–Oct

✔ Raise Customer Satisfaction

Address recurring issues in mixed reviews

Proactively follow up with dissatisfied customers

Encourage re-rating once issues are resolved

<h2 id="project-structure">📁 Project Structure</h2>
✔ Dashboard Pages

Overview Dashboard

Conversion Performance

Social Media Engagement

Customer Reviews & Sentiment

<h2 id="key-insights">🔍 Key Insights</h2>
🟦 Conversion Trends

Average conversion rate: 9.57%

Worst month: October (6.15%)

Best month: January (17.31%)

Strong seasonal impact

🟧 Engagement Trends

Views declined consistently after April

Likes remained near zero → poor interaction quality

Blogs performed best among all content types

🟩 Customer Feedback

Average rating: 3.69

Sentiment breakdown:

Positive: 840

Negative: 226

Mixed Negative: 196

Mixed Positive: 86

Neutral: 15

<h2 id="recommendations">📌 Recommended Actions</h2>
✔ Boost Conversion

Focus on high-performing products (Ski Boots, Hockey Stick, Baseball Glove)

Launch seasonal promotions Jan–Feb and Dec

Improve mid-year performance (Mar–Jun) with targeted campaigns

✔ Improve Engagement

Refresh content strategy (interactive posts, reels, CTAs)

Increase posting frequency Jul–Oct

✔ Raise Customer Satisfaction

Address recurring issues in mixed reviews

Proactively follow up with dissatisfied customers

Encourage re-rating once issues are resolved

<h2 id="project-structure">📁 Project Structure</h2>

<h2 id="run">▶️ How to Run This Project</h2>
1. Restore SQL Database

Open SSMS

Restore MarketingAnalytics.bak

Execute queries.sql
pip install pandas sqlalchemy nltk pyodbc
python sentiment_analysis.py

3. Open Power BI

Connect to SQL Server

Import the sentiment CSV

Open Marketing_Analytics_Dashboard.pbix

<h2 id="author">👤 Author & Contact</h2>

Your Name
📧 Email: your-email@example.com

🔗 LinkedIn: your-linkedin-url
🌐 Portfolio: your-portfolio-url