# Data Aggregation

## Daily Aggregation

### Total Sales:

```sql
SELECT SUM(sales_amount) AS daily_total_sales
FROM fact_sales
JOIN dim_date ON fact_sales.purchase_date = dim_date.purchase_date
GROUP BY dim_date.purchase_date;
```

### Average Sales:

```sql
SELECT AVG(sales_amount) AS daily_avg_sales
FROM fact_sales
JOIN dim_date ON fact_sales.purchase_date = dim_date.purchase_date
GROUP BY dim_date.purchase_date;
```

### Count of Sales by Store:

```sql
SELECT store_id, COUNT(sales_amount) AS daily_sales_by_store
FROM fact_sales
JOIN dim_date ON fact_sales.purchase_date = dim_date.purchase_date
GROUP BY dim_date.purchase_date, store_id;
```

### Quarter Aggregation

### Total Sales

```sql
SELECT SUM(sales_amount) AS weekly_total_sales
FROM fact_sales
JOIN dim_date ON fact_sales.purchase_date = dim_date.purchase_date
GROUP BY dim_date.purchase_quarter_id;
```

### Average Sales:

```sql
SELECT AVG(sales_amount) AS weekly_avg_sales
FROM fact_sales
JOIN dim_date ON fact_sales.purchase_date = dim_date.purchase_date
GROUP BY dim_date.purchase_quarter_id;
```

### Count of Sales by Store:

```sql
SELECT store_id, COUNT(sales_amount) AS weekly_sales_by_store
FROM fact_sales
JOIN dim_date ON fact_sales.purchase_date = dim_date.purchase_date
GROUP BY dim_date.purchase_quarter_id, store_id;
```

## Monthly Aggregation

### Total Sales

```sql
SELECT SUM(sales_amount) AS monthly_total_sales
FROM fact_sales
JOIN dim_date ON fact_sales.purchase_date = dim_date.purchase_date
GROUP BY dim_date.purchase_month_id;
```

### Average Sales:

```sql
SELECT AVG(sales_amount) AS monthly_avg_sales
FROM fact_sales
JOIN dim_date ON fact_sales.purchase_date = dim_date.purchase_date
GROUP BY dim_date.purchase_month_id;
```

### Count of Sales by Store:

```sql
SELECT store_id, COUNT(sales_amount) AS monthly_sales_by_store
FROM fact_sales
JOIN dim_date ON fact_sales.purchase_date = dim_date.purchase_date
GROUP BY dim_date.purchase_month_id, store_id;
```
