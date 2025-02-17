
```markdown
### SQL Exploratory Data Analysis (EDA) Project | Full Hands-On Portfolio Project

### Overview of SQL Projects
> "In any data analytics project using SQL, there are three types of projects to consider: data warehousing, exploratory data analysis, and advanced analytics."

- **Data Warehousing**: Focuses on structuring/organizing data for analysis
- **Exploratory Data Analysis (EDA)**: Uses basic SQL to uncover insights through questions
- **Advanced Analytics**: Applies complex SQL for business-specific reporting

## Getting Started with Data Sets
> "The first step in any data project is acquiring data sets through scripts, flat files, or backups."

### Methods to Create Databases:
1. Execute SQL scripts to build structure
2. Import data files directly
3. Restore from database backup
> **Recommended**: SQL scripts for efficiency

## Understanding Dimensions and Measures
> "Dimensions describe attributes, measures provide quantifiable metrics."

### Classification Criteria:
- **Dimension**: Non-numeric values (e.g., `customer_id`, `product_category`)
- **Measure**: Numeric, aggregatable values (e.g., `sales_amount`, `quantity`)

**Example Analysis Structure:**
```sql
SELECT 
  dimension_column, 
  SUM(measure_column) AS total_metric
FROM table
GROUP BY dimension_column
```

## Exploring Database Structure
### Key Queries:
```sql
-- List all tables
SELECT * FROM information_schema.tables

-- Get column details
SELECT * FROM information_schema.columns 
WHERE table_name = 'sales'
```

## Date Analysis Fundamentals
### Sales Date Boundaries:
```sql
SELECT 
  MIN(order_date) AS first_order,
  MAX(order_date) AS last_order,
  DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS year_span
FROM sales
```

**Insight**: Orders spanned 4 years (Dec 2010 - Jan 2014)

## Customer Demographics
### Age Calculation:
```sql
SELECT 
  MIN(birth_date) AS oldest_customer,
  MAX(birth_date) AS youngest_customer,
  DATEDIFF(YEAR, MIN(birth_date), GETDATE()) AS max_age,
  DATEDIFF(YEAR, MAX(birth_date), GETDATE()) AS min_age
FROM customers
```

## Key Business Metrics
### Unified Metrics Query:
```sql
SELECT 'Total Sales' AS metric, SUM(sales_amount) AS value FROM sales
UNION ALL
SELECT 'Avg Price', AVG(sales_amount) 
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_id)
UNION ALL
SELECT 'Unique Customers', COUNT(DISTINCT customer_id)
```

**Results**:
- Total Sales: $29M 
- Orders: 27K unique
- Customers: 8K registered (7.8K active)

## Dimensional Analysis
### Top Products by Revenue:
```sql
SELECT TOP 5
  p.product_name,
  SUM(s.sales_amount) AS total_revenue
FROM sales s
LEFT JOIN products p ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC
```

### Worst Performing Categories:
```sql
SELECT 
  product_category,
  SUM(sales_amount) AS total_revenue
FROM sales s
LEFT JOIN products p ON s.product_key = p.product_key
GROUP BY product_category
ORDER BY total_revenue ASC
```

**Insights**:
- Bikes generated $28M (96% of revenue)
- Accessories/Clothing < $1M combined

## Advanced Techniques
### Ranking with Window Functions:
```sql
WITH ranked_products AS (
  SELECT
    product_name,
    SUM(sales_amount) AS revenue,
    DENSE_RANK() OVER (ORDER BY SUM(sales_amount) DESC) AS rank
  FROM sales
  GROUP BY product_name
)
SELECT * FROM ranked_products WHERE rank <= 5
```

## Key Takeaways
1. Always separate dimensions vs measures
2. Use `DISTINCT` for accurate unique counts
3. Combine metrics with `UNION ALL` for dashboard-style reports
4. Leverage window functions for complex rankings
5. Analyze both top/bottom performers for full perspective
```

