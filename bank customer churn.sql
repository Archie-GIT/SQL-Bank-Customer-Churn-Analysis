SELECT * FROM Bank_Churn;
--Total rows
SELECT 
    COUNT(*) 
    FROM Bank_Churn;

--Checking for null column
SELECT *
    FROM Bank_Churn
    WHERE Surname IS NULL;

-- Checking for duplicate IDs
SELECT 
    CustomerID, 
    COUNT(*) AS Duplicate_ID
    FROM Bank_Churn
    GROUP BY CustomerID
    HAVING COUNT(CustomerID) >1;

--Churning rate of customers
SELECT 
    COUNT(*) AS Total_Customers, 
    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
    (SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)) * 100/COUNT(*),2) AS Churned_Percentage
    FROM Bank_Churn

--Churing rate based on customer age
SELECT 
    Age_Group, 
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Total_exited, 
    COUNT(*) AS Total_customers,
    ROUND
        (SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END)*100/COUNT(*),2) AS Churn_rate_grouped
    FROM
(SELECT 
    Exited,
    CASE WHEN "Age" < 30 THEN 'Below_30'
         WHEN "Age" BETWEEN 30 AND 60 THEN '30-60'
         ELSE 'Above_60' END AS Age_group
    FROM Bank_Churn) AS t
GROUP BY Age_group
ORDER BY Age_group DESC

--Churing rate based on customer geography
SELECT 
    Geography, 
    COUNT(*) AS Total_cust,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Exited_cust,
    CAST(
        SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) *100.0 /COUNT(*) AS DECIMAL(10,2)) AS Churn_rate_geog
    FROM Bank_Churn
    GROUP BY Geography
    ORDER BY Churn_rate_geog;

--Churing rate based on customer Gender
SELECT 
    Gender, 
    COUNT(*) AS Total_cust,
    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END) AS Churn_gender,
    CAST(
        SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)*100.0/COUNT(*) AS DECIMAL(10,2))AS Churn_rate_gen
    FROM Bank_Churn
    GROUP BY Gender
    ORDER BY Churn_rate_gen;

--Active & Inactive cust exited percent
SELECT 
    CASE WHEN "IsActiveMember" = 1 THEN 'Active' ELSE 'Inactive' END AS Cust_Actvity,
    COUNT(*) AS Cust_count,
    CAST(
        SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END) * 100.00/COUNT(*) AS decimal (10,2)) AS Churn_rate_activity
    FROM Bank_Churn
    GROUP BY "IsActiveMember";

--Numb of product & churn rate
SELECT 
    NumOfProducts, 
    COUNT(*) AS Total_cust,
    CAST(
        SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)*100.00/COUNT(*) AS decimal (10,2)) AS Churn_rate_product
    FROM Bank_Churn
    GROUP BY NumOfProducts
    ORDER BY NumOfProducts;

    SELECT * FROM Bank_Churn;

--Cust risk segmentation based on credit score and their churn rate
SELECT
    Risk_measure,
    CAST(
        SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)*100/COUNT(*) AS DECIMAL(10,2)) AS Churn_rate_Credit
    FROM (
        SELECT   
        CreditScore,Exited,
        CASE WHEN "CreditScore" BETWEEN 350 AND 500 THEN 'Low risk'    
        WHEN "CreditScore" BETWEEN 501 AND 699 THEN 'Medium risk'
        ELSE 'High risk' END AS Risk_measure
        FROM Bank_Churn)t
    GROUP BY Risk_measure;


---Ranking hihest risk segment Based on geog & gender And place it in View
CREATE VIEW Churn_rate AS
SELECT 
    Geography,
    Gender,
    CAST
    (SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END) * 100.0 / 
    COUNT(*) AS decimal (10,2)) AS churn_rate,
    RANK() OVER (ORDER BY ROUND(SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END) * 100.0 / 
    COUNT(*), 2) DESC) AS risk_rank
FROM bank_churn
GROUP BY Geography, Gender;

--Which segment contributes most to total churn?
SELECT 
    Geography,
    SUM(CASE WHEN "Exited" =1 THEN 1 ELSE 0 END) AS churned_cust,
    CAST(
        SUM(CASE WHEN "Exited" =1 THEN 1 ELSE 0 END) * 100.00/
        (SELECT SUM(CASE WHEN "Exited" =1 THEN 1 ELSE 0 END) FROM Bank_Churn)
        AS decimal (10,2)) Churn_rate
    FROM Bank_Churn
    GROUP BY Geography;
--"Churn rate identifies risky segments, 
--but churn contribution identifies segments driving overall business loss. 
--I used both metrics to prioritize retention strategies."

--High balance customers churning is worse than low balance ones.
SELECT 
    Salary_distri,
    COUNT(*) AS Cust_cnt,
    SUM(CASE WHEN Exited =1 THEN 1 ELSE 0 END) AS churned_cust,
    CAST(
        SUM(CASE WHEN Exited =1 THEN 1 ELSE 0 END) * 100.00/COUNT(*) 
        AS decimal (10,2)) Churn_rate 
        FROM
        (SELECT 
            Exited,
            CASE WHEN "EstimatedSalary" <= 100000 THEN 'Low_salary'
            WHEN "EstimatedSalary" BETWEEN 100001 AND 150000 THEN 'Medium_salary'
            ELSE 'High_salary' END Salary_distri 
        FROM Bank_Churn) t
    GROUP BY Salary_distri;

--Tenure-Based Risk
SELECT 
    Tenure_dist,
    COUNT(*) AS Cust_cnt,
    SUM(CASE WHEN Exited =1 THEN 1 ELSE 0 END) AS churned_cust,
    CAST(
        SUM(CASE WHEN Exited =1 THEN 1 ELSE 0 END) * 100.00/COUNT(*) 
        AS decimal (10,2)) Churn_rate 
        FROM(
       SELECT  
            Exited,
            CASE WHEN Tenure BETWEEN 0 AND 3 THEN 'New Customer'
            WHEN Tenure BETWEEN 4 AND 7 THEN 'Mid Term'
            ELSE 'Loyal Customer' END AS Tenure_dist
            FROM Bank_Churn) t
    GROUP BY Tenure_dist
    ORDER BY Tenure_dist;

--Multiple factors risk
SELECT 
    Geography,
    Gender,
    NumOfProducts,
    SUM(CASE WHEN Exited =1 THEN 1 ELSE 0 END) AS churned_cust,
    CAST(
        SUM(CASE WHEN Exited =1 THEN 1 ELSE 0 END) * 100.00/COUNT(*) 
        AS decimal (10,2)) Churn_rate 
    FROM Bank_Churn
    GROUP BY Geography,Gender,NumOfProducts
    ORDER BY Churn_rate DESC

    SELECT COUNT(*) FROM bank_churn 
    WHERE EstimatedSalary >100000 AND Exited = 0;


--High-Value Customer Risk
SELECT
    Cust_divi,
    COUNT(*)
    FROM
    (SELECT
        CASE WHEN EstimatedSalary >100000 AND Exited = 1 THEN 'High value gain'
        WHEN EstimatedSalary >100000 AND Exited = 0 THEN 'High value lost'
        ELSE 'Regular' END AS Cust_divi
    FROM Bank_Churn) t
    GROUP BY Cust_divi