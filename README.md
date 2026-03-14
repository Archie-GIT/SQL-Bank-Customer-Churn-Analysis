# Bank Customer Churn Analysis (SQL Project)

## 1. Short Description / Purpose

The Bank Customer Churn Analysis project focuses on identifying patterns and factors that contribute to customer attrition in the banking sector. 
Using **SQL**, the project analyzes customer demographics, account activity, and financial behavior to understand why customers leave the bank.
The analysis aims to help financial institutions detect high-risk customer segments, improve retention strategies, and support data-driven decision-making in customer relationship management.

---

# 2. Tech Stack

The project was built using the following tools and technologies:

• 🗄 **SQL** – Used for querying, aggregating, and analyzing customer churn data.

• 🧠 **Advanced SQL Concepts** – Including:

* Common Table Expressions (CTEs)
* Subqueries
* Window Functions
* Aggregations
* CASE statements for segmentation

• 📊 **Data Analysis Techniques** – Used to identify churn trends across customer segments such as geography, age, credit score, and account balance.

• 📁 **File Format**

* `.sql` for query scripts
* `.csv` dataset for raw data

---

# 3. Data Source

**Source:** Public banking customer churn dataset.

The dataset contains customer-level information from a bank, including demographics, financial status, and account activity indicators.

### Key Columns in the Dataset

* Customer ID
* Credit Score
* Geography
* Gender
* Age
* Tenure (years with the bank)
* Balance
* Number of Products
* Has a credit card
* Is an active member
* Estimated Salary
* Churn Status (Exited)

The **Exited column** indicates whether a customer has left the bank.

---

# 4. Features / Highlights

## Business Problem

Customer churn is a major challenge for financial institutions because acquiring new customers is significantly more expensive than retaining existing ones.

Banks need to answer important questions such as:

* Which customer segments are most likely to churn?
* Does churn vary by geography or demographics?
* Are inactive customers more likely to leave?
* Do account balances or product usage influence churn?

Without structured analysis, it is difficult to identify churn patterns and risk factors.

---

# Goal of the Analysis

The goal of this SQL analysis is to:

* Identify key drivers behind customer churn
* Segment customers based on demographic and financial attributes
* Measure churn rates across different groups
* Provide insights that help improve customer retention strategies

---

# Walkthrough of Key SQL Analyses

### Overall Churn Rate

Calculated the percentage of customers who exited the bank.
This provides a baseline understanding of the overall churn level.

---

### Churn by Geography

Analyzed churn rates across different countries to identify geographic patterns in customer attrition.
This helps determine which regions require stronger retention strategies.

---

### Churn by Age Group

Segmented customers into age brackets and analyzed churn rates across different age groups.
This helps understand how customer lifecycle stages influence retention.

---

### Churn by Account Balance

Examined whether customers with higher balances are more or less likely to leave the bank.
This insight helps prioritize high-value customer retention efforts.

---

### Churn by Product Usage

Analyzed churn rates based on the number of bank products used by customers.
Customers with fewer products often show higher churn risk.

---

### Active vs Inactive Customers

Compared churn behavior between active and inactive customers.
Inactive customers often represent a higher churn risk group.

---

# Business Impact & Insights

**Customer Retention Strategy:**
Banks can focus retention efforts on high-risk customer segments identified through churn patterns.
**Geographic Targeting:**
Regions with higher churn rates may require improved services or marketing strategies.
**Product Engagement:**
Encouraging customers to use multiple financial products can increase retention.
**Customer Lifecycle Management:**
Age and tenure analysis help banks design personalized engagement strategies.
**Risk Identification:**
Financial institutions can proactively identify customers likely to churn and implement retention programs.

---

# Example Analytical Questions Answered

* What percentage of customers leave the bank?
* Which country has the highest churn rate?
* Are older customers more likely to churn?
* Do inactive customers churn more often?
* Does account balance influence churn probability?

---

✅ This project demonstrates skills in:

* Data exploration
* Business-focused SQL analysis
* Customer segmentation
* Analytical problem solving

---

If you want, I can also show you **5 SQL queries from your churn project that make recruiters instantly recognize you as a strong data analyst**.
