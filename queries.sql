use PortfolioProject_MarketingAnalytics;

-- Products Table
Select * from dbo.products;

SELECT 
    ProductID, 
    ProductName, 
    Price, 
	

    CASE 
        WHEN Price < 50 THEN 'Low'  
        WHEN Price BETWEEN 50 AND 200 THEN 'Medium'  
        ELSE 'High'  
    END AS PriceCategory  

FROM 
    dbo.products;  

--Customers Table
select * from dbo.customers;

SELECT 
    c.CustomerID, 
    c.CustomerName,  
    c.Email, 
    c.Gender, 
    c.Age,  
    g.Country,  
    g.City  
FROM 
    dbo.customers as c  
LEFT JOIN
    dbo.geography g  
ON 
    c.GeographyID = g.GeographyID; 

--Customer Review Table
select * from dbo.customer_reviews;
SELECT 
    ReviewID,  
    CustomerID,  
    ProductID, 
    ReviewDate,  
    Rating, 
    REPLACE(ReviewText, '  ', ' ') AS ReviewText
    -- Cleans up the ReviewText by replacing double spaces with single spaces to ensure the text is more readable and standardized
FROM 
    dbo.customer_reviews; 

--Engagement Table
select * from dbo.engagement_data;
SELECT 
    EngagementID,  
    ContentID, 
	CampaignID,  
    ProductID,  
    UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType,  
    LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) - 1) AS Views, 
    RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks, 
    Likes,  
    -- Converts the EngagementDate to the dd.mm.yyyy format
    FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') AS EngagementDate 
FROM 
    dbo.engagement_data 

--Customer Journey Table
select * from dbo.customer_journey;

WITH DuplicateRecords AS (
    SELECT 
        JourneyID,  
        CustomerID, 
        ProductID,  
        VisitDate,  
        Stage, 
        Action,  
        Duration,  
        -- Use ROW_NUMBER() to assign a unique row number to each record within the partition defined below
        ROW_NUMBER() OVER (
            -- PARTITION BY groups the rows based on the specified columns that should be unique
            PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action  
            ORDER BY JourneyID  
        ) AS row_num  
    FROM 
        dbo.customer_journey  
)
    
SELECT *
FROM DuplicateRecords
ORDER BY JourneyID;



SELECT 
    JourneyID,  
    CustomerID,  
    ProductID,  
    VisitDate, 
    Stage,  
    Action, 
    COALESCE(Duration, avg_duration) AS Duration 
FROM 
    (
        -- Subquery to process and clean the data
        SELECT 
            JourneyID,  
            CustomerID,  
            ProductID, 
            VisitDate, 
            UPPER(Stage) AS Stage,  -- Converts Stage values to uppercase for consistency in data analysis
            Action, 
            Duration,  
            AVG(Duration) OVER (PARTITION BY VisitDate) AS avg_duration,  -- Calculates the average duration for each date, using only numeric values
            ROW_NUMBER() OVER (
                PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action  -- Groups by these columns to identify duplicate records
                ORDER BY JourneyID  
            ) AS row_num  
        FROM 
            dbo.customer_journey
    ) AS subquery  -- Names the subquery for reference in the outer query
WHERE 
    row_num = 1; 