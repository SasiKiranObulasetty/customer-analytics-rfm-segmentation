# Customer Analytics & RFM Segmentation

## Project Overview

This project analyzes customer purchasing behavior using RFM (Recency, Frequency, Monetary) analysis and customer segmentation.

The objective is to identify valuable customers, loyal customers, potential customers, and at-risk customers, and convert the analysis into actionable business insights using Python, MySQL, Excel, and Power BI.

## Business Problem

The business needs to understand:

* Which customers generate the most revenue?
* Which customers are highly valuable?
* Which customers are becoming inactive?
* How are customers distributed across different segments?
* Which countries generate the most revenue?
* How does revenue change over time?
* What actions can be taken to retain valuable customers and reactivate inactive customers?

## Dataset

The dataset contains online retail transaction information including:

* InvoiceNo
* StockCode
* Description
* Quantity
* InvoiceDate
* UnitPrice
* CustomerID
* Country
* Revenue

## Data Cleaning & Preparation

The data was prepared before performing customer analysis.

Major steps included:

* Handling missing customer information
* Removing invalid transaction records
* Preparing transaction-level revenue
* Converting date columns into appropriate date formats
* Creating customer-level aggregated data
* Calculating Recency, Frequency, and Monetary values
* Preparing the data for customer segmentation

## RFM Analysis

RFM analysis was used to understand customer behavior.

### Recency

Measures how recently a customer made a purchase.

Lower Recency indicates a more recently active customer.

### Frequency

Measures how frequently a customer makes purchases.

Higher Frequency indicates stronger customer engagement.

### Monetary

Measures how much revenue a customer generates.

Higher Monetary value indicates a more valuable customer.

## Skewness Transformation

The original RFM data was highly skewed:

* Recency: 1.242934
* Frequency: 11.976299
* Monetary: 19.551828

Log transformation was applied to reduce the effect of extreme values.

After transformation:

* Recency: -0.378920
* Frequency: 1.214115
* Monetary: 0.400774

The transformed RFM features were then used for clustering.

## Customer Segmentation

K-Means clustering was evaluated for different values of K.

Silhouette scores:

| K | Silhouette Score |
| - | ---------------: |
| 2 |           0.4329 |
| 3 |           0.3376 |
| 4 |           0.3378 |
| 5 |           0.3166 |
| 6 |           0.3137 |
| 7 |           0.3090 |
| 8 |           0.3020 |

Although K=2 produced the highest silhouette score, K=4 was selected because it provided more meaningful and actionable business segments.

The four customer segments were:

1. VIP Customers
2. Loyal Customers
3. Potential Customers
4. At-Risk Customers

## Customer Segment Results

| Segment             | Customers | Customer % |       Revenue | Revenue % | Avg Recency | Avg Frequency | Avg Monetary |
| ------------------- | --------: | ---------: | ------------: | --------: | ----------: | ------------: | -----------: |
| VIP Customers       |       684 |     15.78% | £5,598,068.68 |    64.02% |       11.70 |         13.96 |    £8,184.31 |
| Loyal Customers     |     1,175 |     27.09% |    £2,125,914 |    24.30% |       67.01 |          4.18 |    £1,809.29 |
| Potential Customers |       840 |     19.38% |   £446,683.58 |     5.11% |       18.53 |          2.10 |      £531.77 |
| At-Risk Customers   |     1,639 |     37.75% |   £576,211.90 |     6.59% |      183.10 |          1.33 |      £351.56 |

## SQL Analysis

MySQL was used to perform business-oriented analysis on the customer and transaction data.

The SQL analysis included:

* Customer counts
* Transaction counts
* Total revenue
* Average order value
* Customer segment analysis
* Revenue contribution by segment
* VIP customer analysis
* Top customers by monetary value
* Customer transaction history
* Identification of customers not present in the segmentation table
* Aggregated customer-level metrics

The final MySQL database contains:

* `transactions`
* `customers`
* `customer_segments`

Total customers: **4,338**

Total transaction rows: **392,692**

Segmented customers: **4,334**

## Excel Analysis

Excel was used to create an analysis summary and visualizations.

The Excel analysis includes:

* Segment performance table
* Customer counts by segment
* Revenue by segment
* Revenue contribution
* Average Recency
* Average Frequency
* Average Monetary
* Customer distribution visualization
* Revenue contribution visualization

## Power BI Dashboard

An interactive Customer Analytics Dashboard was created using Power BI.

### KPI Cards

* Total Revenue: **£8.89M**
* Total Customers: **4K**
* Total Orders: **18.53K**
* Average Order Value: **£479.56**

### Dashboard Visualizations

The dashboard contains:

* Revenue Contribution by Customer Segment
* Customer Distribution by Segment
* Monthly Revenue Trend
* Top 10 Countries by Revenue
* Customer Value: Frequency vs Monetary

## Key Business Insights

### 1. VIP Customers Generate the Majority of Revenue

VIP customers represent only **15.78% of customers**, but contribute approximately **64.02% of total revenue**.

This makes VIP customers the most important segment for customer retention.

### 2. At-Risk Customers Are the Largest Segment

At-Risk customers represent **37.75% of all customers**, making them the largest customer group.

Their average Recency is **183.10 days**, while their average Frequency is only **1.33**.

This indicates a significant customer reactivation opportunity.

### 3. Loyal Customers Generate Significant Revenue

Loyal customers represent **27.09% of customers** and contribute approximately **24.30% of revenue**.

Increasing their purchase frequency and average spending could potentially move more customers into the VIP segment.

### 4. Potential Customers Have Growth Opportunity

Potential customers represent **19.38% of customers** but contribute only **5.11% of revenue**.

Targeted promotions, product recommendations, and repeat-purchase campaigns can be used to increase their engagement.

### 5. United Kingdom Dominates Revenue

The United Kingdom is the largest revenue-generating country by a significant margin compared with the other countries in the dataset.

This indicates strong dependence on the UK market and provides an opportunity to investigate international market growth.

### 6. Strong End-of-Year Revenue Growth

The monthly revenue trend shows a significant increase during the later months of the year, with revenue reaching its highest level around November before declining in December.

This suggests seasonal purchasing behavior that can be considered when planning inventory and marketing campaigns.

## Business Recommendations

### VIP Customers

* Provide personalized offers
* Introduce loyalty rewards
* Focus on customer retention
* Provide premium customer experiences
* Avoid excessive discounting because these customers already have high value

### Loyal Customers

* Encourage increased purchase frequency
* Use cross-selling and upselling
* Introduce loyalty programs
* Recommend complementary products

### Potential Customers

* Encourage repeat purchases
* Provide targeted promotions
* Use personalized product recommendations
* Develop campaigns to increase purchase frequency

### At-Risk Customers

* Launch customer reactivation campaigns
* Send personalized offers
* Provide limited-time incentives
* Use reminders and targeted communication
* Identify previously valuable customers within this segment for priority reactivation

## Tools & Technologies

* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn
* Scikit-learn
* K-Means Clustering
* RFM Analysis
* MySQL
* MySQL Workbench
* Microsoft Excel
* Microsoft Power BI
* DAX

## Project Workflow

```text
Raw Transaction Data
        ↓
Data Cleaning
        ↓
Feature Engineering
        ↓
Customer-Level Aggregation
        ↓
RFM Calculation
        ↓
Skewness Analysis
        ↓
Log Transformation
        ↓
Feature Scaling
        ↓
K-Means Clustering
        ↓
Customer Segmentation
        ↓
SQL Business Analysis
        ↓
Excel Analysis
        ↓
Power BI Dashboard
        ↓
Business Insights & Recommendations
```

## Final Outcome

The project transformed raw retail transaction data into a complete customer analytics solution.

Python was used for data preparation, RFM analysis, transformation, and customer segmentation.

MySQL was used for structured business analysis and querying.

Excel was used for supporting analysis and visualization.

Power BI was used to create an interactive dashboard that communicates customer behavior, revenue contribution, customer distribution, geographical performance, and revenue trends.

The final segmentation provides a practical framework for prioritizing customer retention, loyalty development, customer growth, and reactivation strategies.
