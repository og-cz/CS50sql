# Viewing

- [View](#view)
- [why we do views?](#why-we-do-views)
- [Simplifying](#simplifying)
- [CREATE VIEW name AS](#create-view-name-as)
- [Aggregating](#aggregating)
- [Temporary Views](#temporary-views)
- [Common Table Expression (CTE)](#common-table-expression-cte)
- [partitioning](#partitioning)
  - [Types of SQL Partitioning](#types-of-sql-partitioning)
    - [Range Partitioning](#range-partitioning)
    - [List Partitioning](#list-partitioning)
    - [Hash Partitioning](#hash-partitioning)
    - [Composite](#composite)
- [Securing](#securing)
- [soft deletions](#soft-deletions)

### View
A virtual table defined by a query 

### why we do views?
- Simplifying   -> simplify data
- Aggregating   -> to sum up some values and store that 
- Partitioning  -> divide the data into logical pieces
- Securing      -> or hide some columns we dont want others to see
- ...           -> and many more...

### Simplifying
Simplifying in SQL refers to the process of making queries easier to read, maintain, and sometimes more efficient by restructuring or rephrasing them. 

### CREATE VIEW name AS 
A CREATE VIEW statement in SQL lets you create a virtual table a saved SQL query that behaves like a table but does not store data itself.
```sql
CREATE VIEW view_name AS
SELECT column1, column2
FROM table_name
WHERE condition;
```

### Aggregating
Aggregating on views means creating a SQL VIEW that contains aggregated data that’s been summarized using functions like:

- SUM()
- COUNT()
- AVG()
- MAX() / MIN()
- GROUP BY
```sql
CREATE VIEW customer_totals AS
SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id;
```

### Temporary Views

ChatGPT said:

Temporary views are views that only exist for the duration of your database session — meaning:

- They disappear when you disconnect
- They are not saved permanently in the database
- Other users can’t see them
- They work just like normal views, but are short-lived

Some databases call them temporary views, some call them session views, and others achieve the same thing using CTEs (WITH queries).
```sql
CREATE TEMP VIEW temp_sales_summary AS
SELECT customer_id, SUM(amount) AS total
FROM sales
GROUP BY customer_id;
```

### Common Table Expression (CTE)

Its just a view but exists in a single duration of a query, a regular view exisit forever, and a temporary view exist in a single connection while a CTE exists for a single query

In a CTE, we use SELECT two times but for different purposes.
- 1st SELECT → fills the CTE
- 2nd SELECT → uses the CTE

```SQL
WITH high_scores AS (
    SELECT name, score
    FROM students
    WHERE score > 90
)
SELECT *
FROM high_scores;
```

### partitioning
Partitioning = splitting one big table into smaller, faster pieces…but logically it still acts like one table.

Think of it like cutting a giant cake into slices it’s still one cake, just divided for easier serving.
#### Types of SQL Partitioning
1. Range Partitioning

Split by ranges:

- dates
- ages
- prices

```sql
PARTITION BY RANGE (year)
```

2. List Partitioning

Split by values:

- country
- type
- category

3. Hash Partitioning

Database spreads the rows evenly using a hash function.
Good when data distribution is random.

4. Composite

Mix of the above.

```sql
CREATE VIEW "2021" AS
SELECT 
    "id",
    "title"
FROM books
WHERE "year" = 2021; -- the actual partitioning
```


### Securing

A view can hide sensitive columns so that users only see what you allow them to see.

It’s basically data filtering for privacy.

You don’t give users direct access to the raw table, You give them access only to a safe view.
```sql
employees
-------------------------
id | name | salary | address | ssn

❌ You don’t want this:
SELECT * FROM employees;

✔️ Create a secure view:
CREATE VIEW public_employee_info AS
SELECT 
    id,
    name
FROM employees;
```

### soft deletions

this is soft deletions, a column named deleted can be represented as (0 or 1) or (True or False)

| id | name        | email                | deleted |
|----|-------------|----------------------|---------|
| 1  | Alice Cruz  | alice@example.com    | FALSE   |
| 2  | Mark Reyes  | mark@example.com     | TRUE    |
| 3  | John Santos | john@example.com     | FALSE   |
