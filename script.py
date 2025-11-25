# pip install pandas nltk sqlalchemy pyodbc

import pandas as pd
from sqlalchemy import create_engine
import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer

# Download VADER lexicon
nltk.download('vader_lexicon')

# ----------------------------
# 1️⃣ SQLAlchemy Database Engine
# ----------------------------
# Windows Authentication (trusted connection)
# engine = create_engine(
#     "mssql+pyodbc://LAPTOP-TRL043NL\Admin/PortfolioProject_MarketingAnalytics"
#     "?driver=SQL+Server&trusted_connection=yes"
# )
engine = create_engine(
    "mssql+pyodbc://@LAPTOP-TRL043NL/PortfolioProject_MarketingAnalytics"
    "?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes"
)

# ----------------------------
# 2️⃣ Fetch Data from SQL Server
# ----------------------------
query = """
SELECT ReviewID, CustomerID, ProductID, ReviewDate, Rating, ReviewText
FROM dbo.customer_reviews
"""

customer_reviews_df = pd.read_sql(query, engine)

# ----------------------------
# 3️⃣ Sentiment Analyzer Setup
# ----------------------------
sia = SentimentIntensityAnalyzer()

def calculate_sentiment(review):
    sentiment = sia.polarity_scores(review)
    return sentiment['compound']

def categorize_sentiment(score, rating):
    if score > 0.05:
        if rating >= 4: 
            return 'Positive'
        elif rating == 3: 
            return 'Mixed Positive'
        else: 
            return 'Mixed Negative'
    elif score < -0.05:
        if rating <= 2: 
            return 'Negative'
        elif rating == 3: 
            return 'Mixed Negative'
        else: 
            return 'Mixed Positive'
    else:
        if rating >= 4: 
            return 'Positive'
        elif rating <= 2: 
            return 'Negative'
        else: 
            return 'Neutral'

def sentiment_bucket(score):
    if score >= 0.5:
        return '0.5 to 1.0'
    elif 0.0 <= score < 0.5:
        return '0.0 to 0.49'
    elif -0.5 <= score < 0.0:
        return '-0.49 to 0.0'
    else:
        return '-1.0 to -0.5'

# ----------------------------
# 4️⃣ Apply Sentiment Processing
# ----------------------------
customer_reviews_df['SentimentScore'] = customer_reviews_df['ReviewText'].apply(calculate_sentiment)

customer_reviews_df['SentimentCategory'] = customer_reviews_df.apply(
    lambda row: categorize_sentiment(row['SentimentScore'], row['Rating']),
    axis=1
)

customer_reviews_df['SentimentBucket'] = customer_reviews_df['SentimentScore'].apply(sentiment_bucket)

# ----------------------------
# 5️⃣ Output Results
# ----------------------------
print(customer_reviews_df.head())

customer_reviews_df.to_csv("fact_customer_reviews_with_sentiment.csv", index=False)
