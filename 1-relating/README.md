# Relating

Relating is how having multiple tables in our database - people, places, things to have them relate to one another how we do in the real world

- [Relational Database](#relational-database)
- [Relating](#relating)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Keys](#keys)
  - [ISBN](#isbn)
  - [Primary Key](#primary-key)
  - [Foreign Key](#foreign-key)
  - [Improving Primary Key](#improving-primary-key)
  - [Many to Many](#many-to-many)
- [Subqueries](#subqueries)
- [IN Keyword](#in-keyword)
- [Relating Flow (Logical Execution)](#relating-flow-logical-execution)
- [JOIN](#join)
  - [ON Keyword](#on-keyword)
  - [INNER JOIN](#inner-join)
  - [LEFT JOIN](#left-join)
  - [RIGHT JOIN](#right-join)
  - [FULL OUTER JOIN](#full-outer-join)
  - [Summary Table](#summary-table)
- [Sets](#sets)
  - [INTERSECT](#intersect)
  - [UNION](#union)
  - [EXCEPT](#except)
- [Groups](#groups)
  - [GROUP BY](#group-by)
  - [HAVING](#having)
- [QUICK SUMMARY](#quick-summary)

### relational database

in a database there are the multiple tables inside it... like an author, publisher or whatever relationships inside it

for example:

| Name     | title      |
| -------- | ---------- |
| eva      | boulder    |
| eva      | heavy man  |
| guaz     | white book |
| baltasar | 7 dwarves  |
| baltasar | 163 flight |

### relating

### entity relationship diagram

also called ER Diagrams

<img src="readme-1.png" alt="alt text" width="300"/>

this is a relationship

- zero -> doesnt have anything related to something
- one -> something atleast one thing that relates to it at a table
- many -> some entity can have many entity related to it

| Relationship Type    | Notation              | Meaning (Plain English)                                                                                       | Example                                 | Key Idea                                                     |
| -------------------- | --------------------- | ------------------------------------------------------------------------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ |
| **One-to-One**       | `1 — 1`               | Each entity in A can be related to **at most one** in B, and vice versa.                                      | Person ↔ Passport                       | Perfect pairing (no duplicates).                             |
| **One-and-Only-One** | `1 — 1` _(exclusive)_ | Each entity in A is paired with **exactly one specific** entity in B — and that B belongs **only** to that A. | Husband ↔ Wife (in a monogamous system) | Exclusive one-to-one pair (cannot exist without each other). |
| **One-to-Many**      | `1 — *`               | One entity in A can be related to **many** in B, but each B belongs to **only one** A.                        | Teacher → Students                      | “Parent to children” pattern.                                |
| **Many-to-One**      | `* — 1`               | Many entities in A are linked to **one** in B.                                                                | Students → Department                   | Reverse of one-to-many.                                      |
| **Many-to-Many**     | `* — *`               | Many entities in A can be related to **many** in B.                                                           | Students ↔ Courses                      | Groups linked to groups.                                     |
| **Zero-or-One**      | `0..1`                | Entity may be related to **none or one** of the other type.                                                   | Person → Passport (optional)            | Optional single link.                                        |
| **Zero-or-Many**     | `0..*`                | Entity may be related to **none or multiple** others.                                                         | Customer → Orders                       | Optional, unlimited.                                         |
| **One-or-More**      | `1..*`                | Entity must be related to **at least one**, possibly many.                                                    | Department → Employees                  | At least one required.                                       |

<!--
| Notation              | Relationship Type                        | Min..Max     | Common Phrase                        | Meaning (in words)                                                                       | Example                                                                                                         |
| --------------------- | ---------------------------------------- | ------------ | ------------------------------------ | ---------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| **(1) —— (1)**        | One-to-One (Mandatory ↔ Mandatory)       | 1..1 ↔ 1..1  | _“One and only one on both sides”_   | Each entity **must** have exactly one of the other. Neither can exist without the other. | Each **User** must have exactly one **UserProfile**, and each profile belongs to one user.                      |
| **(1) —— (0..1)**     | One-to-One (Mandatory ↔ Optional)        | 1..1 ↔ 0..1  | _“One and only one to zero or one”_  | One side **must exist**, the other **may or may not**.                                   | Each **Person** may have **zero or one Passport**.                                                              |
| **(0..1) —— (0..1)**  | One-to-One (Optional ↔ Optional)         | 0..1 ↔ 0..1  | _“Zero or one to zero or one”_       | Both sides are **optional** — they can exist independently or be paired.                 | A **Patient** may or may not have **one Insurance record**, and vice versa.                                     |
| **(1) —— (1..\*)**    | One-to-Many (Mandatory ↔ Mandatory many) | 1..1 ↔ 1..\* | _“One and only one to one or more”_  | One side **must have** at least one related record; the other can have **many**.         | A **Department** must have **one or more Employees**.                                                           |
| **(1) —— (0..\*)**    | One-to-Many (Mandatory ↔ Optional many)  | 1..1 ↔ 0..\* | _“One and only one to zero or many”_ | One side **must exist**, the other may have **none or many**.                            | A **Teacher** may teach **zero or many Students**.                                                              |
| **(0..1) —— (1..\*)** | One-to-Many (Optional ↔ Mandatory many)  | 0..1 ↔ 1..\* | _“Zero or one to one or more”_       | One side **optional**, but the other must have **at least one**.                         | A **Course** may belong to **zero or one Department**, but a **Department** must offer **one or more Courses**. |
| **(0..1) —— (0..\*)** | One-to-Many (Optional ↔ Optional many)   | 0..1 ↔ 0..\* | _“Zero or one to zero or many”_      | Both sides optional — may or may not exist.                                              | A **Customer** may place **zero or many Orders**; some Orders may not yet be assigned to a Customer.            |
| **(1.._) —— (1.._)**  | Many-to-Many (Mandatory ↔ Mandatory)     | 1.._ ↔ 1.._  | _“One or more to one or more”_       | Each side must relate to at least one of the other.                                      | Every **Student** must take **at least one Course**, and every **Course** must have **at least one Student**.   |
| **(1.._) —— (0.._)**  | Many-to-Many (Mandatory ↔ Optional many) | 1.._ ↔ 0.._  | _“One or more to zero or many”_      | One side mandatory, the other optional.                                                  | Each **Teacher** teaches **one or more Subjects**, but some **Subjects** may not yet have a Teacher.            |
| **(0.._) —— (0.._)**  | Many-to-Many (Optional ↔ Optional)       | 0.._ ↔ 0.._  | _“Zero or many to zero or many”_     | Fully optional relationship; both sides can have zero or many connections.               | A **Student** may take **zero or many Courses**, and a **Course** may have **zero or many Students**.           | -->

### keys

this are fundamental idea that relates database one from to another
which has 2 parts primary key and foreign key

#### ISBN

every book has a unique identifier called ISBN like _"073-157842-234"_

- usually when we are finding books to help in finding specific we have this key

#### primary key

- this is similar to primary key to uniquely identify each books or data
  | isbn | title |
  | -------------- | ---------- |
  | 073-157842-234 | Boulder |
  | 978-1234567890 | Heavy Man |

#### foreign key

- is simply taking a primary key to another table

For example, if you have an `authors` table and a `books` table:

authors table

| author_id | name     |
| --------- | -------- |
| 1         | Eva      |
| 2         | Guaz     |
| 3         | Baltasar |

books table

| id  | title      | author_id |
| --- | ---------- | --------- |
| 1   | Boulder    | 1         |
| 2   | Heavy Man  | 1         |
| 3   | White Book | 2         |
| 4   | 7 Dwarves  | 3         |
| 5   | 163 Flight | 3         |

#### improving primary key

- instead of using ISBN _"073-157842-234"_, we can create another primary key called ID that starts with one
  | id | isbn | title |
  |-----|---------------|--------------|
  | 1 | 073-157842-234| Boulder |
  | 64 | 978-1234567890| Heavy Man |
  | 215 | 978-0987654321| White Book |

#### many to many

it will be easier to relate data using primary key in a authored table turnign it into foreign key

<img src="readme-2.png" alt="alt text" width="300"/>

### subqueries

- also called nested queries, a query inside anothery query
- You use a subquery when you don't know some data (like the ID), but you know another piece of information (like the name).
- The ID is usually the basis for relationships in the database, so you need it to get related records.
  Subqueries help you find the ID (or other key data) automatically, making your queries more flexible and dynamic.

```sql
SELECT title FROM books
WHERE author_id = (
    SELECT author_id FROM authors
    WHERE name = 'Eva'
);
```

### IN keyword

The IN keyword is mainly used in SQL for querying to filter results where a column’s value matches any value in a list or the result of a subquery. It’s not used for table creation or schema design, only for selecting/filtering data in queries.

Example:

```sql
-- Retrieve all students whose grade is exactly 'A'
-- Single-value comparison using '='
SELECT *
FROM students
WHERE grade = 'A';
-- WHERE grade = ('A', 'B'); -- WRONG

-- Retrieve all students whose grade is either 'A' or 'B'
-- Multi-value comparison using 'IN'
SELECT *
FROM students
WHERE grade IN ('A', 'B');
```

### Relating Flow (Logical Execution)

Relating flow in a database is the process of connecting data across multiple tables using relationships (like primary keys and foreign keys). The typical flow is:

1. Identify related tables (e.g., authors and books).
2. Use keys to link records (e.g., author_id in books table refers to id in authors table).
3. Query across tables to get combined or related information (e.g., find all books by a specific author).
4. Use subqueries or joins when you need to fetch related data based on known or unknown values.

### JOIN

- joins is take some tables and temporarily combines it with other tables
- this combines the column of data meaning all instances of that data type

We wrap a query only when we need its result as data in another operation (INTERSECT, UNION, JOIN, etc.).

Why:
Wrapping turns the inner query’s output into a virtual table that SQL can combine.

```sql
-- No wrap needed (simple)
SELECT * FROM students WHERE grade > 90
INTERSECT
SELECT * FROM students WHERE section = 'A';
-- Wrap needed (has ORDER BY / LIMIT)
SELECT * FROM (
    SELECT * FROM students ORDER BY grade DESC LIMIT 10
)
INTERSECT
SELECT * FROM (
    SELECT * FROM students ORDER BY age LIMIT 10
);
```

Note:
If the inner query has ORDER BY or LIMIT, wrapping is required otherwise, optional.

#### ON Keyword

The ON keyword in SQL is used with JOINs to specify the condition for how rows from different tables should be matched

### INNER JOIN

![INNER JOIN](https://www.w3schools.com/sql/img_innerjoin.gif)

**Shows only data that exists in both tables (the matching part).**

| student_id | name    | grade |
| ---------- | ------- | ----- |
| 1          | Alice   | A     |
| 3          | Charlie | B     |

Only rows that **match** between both tables.

### LEFT JOIN

![LEFT JOIN](https://www.w3schools.com/sql/img_leftjoin.gif)

**Shows all data from the LEFT table, and the matching data from the RIGHT table.**

| student_id | name    | grade |
| ---------- | ------- | ----- |
| 1          | Alice   | A     |
| 2          | Bob     | NULL  |
| 3          | Charlie | B     |

Keeps everyone from the **left** (Students), even if they have no grade.

### RIGHT JOIN

![RIGHT JOIN](https://www.w3schools.com/sql/img_rightjoin.gif)

**Shows all data from the RIGHT table, and the matching data from the LEFT table.**

| student_id | name    | grade |
| ---------- | ------- | ----- |
| 1          | Alice   | A     |
| 3          | Charlie | B     |
| 4          | NULL    | C     |

Keeps everyone from the **right** (Grades), even if they have no student.

### FULL OUTER JOIN

![FULL OUTER JOIN](https://www.w3schools.com/sql/img_fulljoin.gif)

**Shows everything from both tables all matches and non-matches.**

| student_id | name    | grade |
| ---------- | ------- | ----- |
| 1          | Alice   | A     |
| 2          | Bob     | NULL  |
| 3          | Charlie | B     |
| 4          | NULL    | C     |

Combines **everything** - left, right, and matches.

#### SUMMARY TABLE

| JOIN Type       | What It Means             | Keeps From         | Missing Side Fills With |
| --------------- | ------------------------- | ------------------ | ----------------------- |
| INNER JOIN      | Only the matching data    | Both (common part) | —                       |
| LEFT JOIN       | All from left + matches   | LEFT table         | NULL for right          |
| RIGHT JOIN      | All from right + matches  | RIGHT table        | NULL for left           |
| FULL OUTER JOIN | All data from both tables | BOTH tables        | NULL for missing sides  |

**Quick Memory Tip:**

- **INNER** → only inside (common part)
- **LEFT** → keep all left side
- **RIGHT** → keep all right side
- **FULL** → keep everything

### sets

- the idea of set in sql we get back some result, which is called result set we got back from out table
- combine or compare rows (whole result sets)
- A row = data about one entity (like one person, one order, one product).

let say we have a diagram of authors and translators:

#### INTERSECT

- find who are surely a author/translator
- Shows only rows that appear in both tables.

#### UNION or UNION ALL

- find all authors or translator or both author/translator
- Combines rows from both tables.

#### EXCEPT

- subtract something like Authors EXCEPT translator
- so only authors/translator and translator is found

### groups

A group in SQL refers to grouping rows that have the same values in specified columns, usually using the GROUP BY clause.

#### GROUP BY

- GROUP BY is used to group rows that have the same value in one or more column
- then you can apply aggregate functions (like COUNT(), SUM(), AVG(), etc.) to each group.

#### HAVING

this is the alternative version of WHERE but only for GROUP when applying agregate functions

```sql
SELECT "book_id", COUNT("rating") AS 'total ratings'
FROM ratings GROUP BY "book_id"
HAVING "total ratings" < 200; -- it use different keyword for groups to apply and not WHERE.
```

### QUICK SUMMARY

- **JOIN** → Combines data from two or more tables using a related column.
- **INNER JOIN** → Shows only rows that exist in both tables.
- **LEFT JOIN (LEFT OUTER JOIN)** → Shows all rows from the left table and matching ones from the right; missing matches become NULL.
- **RIGHT JOIN (RIGHT OUTER JOIN)** → Shows all rows from the right table and matching ones from the left; missing matches become NULL.
- **FULL OUTER JOIN** → Shows all rows from both tables, matching where possible and filling missing parts with NULL.
- **CROSS JOIN** → Combines every row from one table with every row from another (cartesian product).
- **SELF JOIN** → Joins a table with itself, often for comparisons within the same data.

---

- **UNION** → Combines results from two queries and removes duplicates.
- **UNION ALL** → Combines results from two queries and keeps duplicates.
- **INTERSECT** → Returns only the rows that appear in both results.
- **EXCEPT** → Returns rows from the first result that are not in the second.

---

- **GROUP BY** → Groups rows with the same values to use aggregate functions like COUNT(), SUM(), AVG().
- **HAVING** → Filters groups created by GROUP BY; used for aggregate conditions.
- **WHERE** → Filters rows before grouping or joining.
- **ORDER BY** → Sorts the final result in ascending (ASC) or descending (DESC) order.

---

- **PRIMARY KEY** → Uniquely identifies each record in a table.
- **FOREIGN KEY** → References a primary key in another table to create a relationship.
- **SUBQUERY** → A query inside another query, often used to find related data.
- **IN** → Checks if a value exists within a list or subquery result.

**Quick Intuition:**

- **JOIN** → Combine tables.
- **SET** → Compare results.
- **WHERE** → Filter before grouping.
- **HAVING** → Filter after grouping.
- **GROUP BY** → Summarize similar data.
- **ORDER BY** → Arrange the final results neatly.

<!-- - [Relational Database](#relational-database)
- [Relating](#relating)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Keys](#keys)
  - [ISBN](#isbn)
  - [Primary Key](#primary-key)
  - [Foreign Key](#foreign-key)
  - [Improving Primary Key](#improving-primary-key)
  - [Many to Many](#many-to-many)
- [Subqueries](#subqueries)
- [IN Keyword](#in-keyword)
- [Relating Flow (Logical Execution)](#relating-flow-logical-execution)
- [JOIN](#join)
  - [ON Keyword](#on-keyword)
  - [INNER JOIN](#inner-join)
  - [LEFT JOIN](#left-join)
  - [RIGHT JOIN](#right-join)
  - [FULL OUTER JOIN](#full-outer-join)
  - [Summary Table](#summary-table)
- [Sets](#sets)
  - [INTERSECT](#intersect)
  - [UNION](#union)
  - [EXCEPT](#except)
- [Groups](#groups)
  - [GROUP BY](#group-by)
  - [HAVING](#having)

---

### Summary Intuition

- **JOIN**: Combines data from two or more tables using a related column.
- **INNER JOIN**: Shows only rows that exist in both tables.
- **LEFT JOIN (LEFT OUTER JOIN)**: Shows all rows from the left table and matching ones from the right; missing matches become NULL.
- **RIGHT JOIN (RIGHT OUTER JOIN)**: Shows all rows from the right table and matching ones from the left; missing matches become NULL.
- **FULL OUTER JOIN**: Shows all rows from both tables, matching where possible and filling missing parts with NULL.
- **UNION**: Combines results from two queries and removes duplicates.
- **INTERSECT**: Returns only the rows that appear in both results.
- **EXCEPT**: Returns rows from the first result that are not in the second.
- **GROUP BY**: Groups rows with the same values to use aggregate functions like COUNT(), SUM(), AVG().
- **HAVING**: Filters groups created by GROUP BY; used for aggregate conditions.
- **WHERE**: Filters rows before grouping or joining.
- **ORDER BY**: Sorts the final result in ascending (ASC) or descending (DESC) order.
- **PRIMARY KEY**: Uniquely identifies each record in a table.
- **FOREIGN KEY**: References a primary key in another table to create a relationship.
- **SUBQUERY**: A query inside another query, often used to find related data.
- **IN**: Checks if a value exists within a list or subquery result. -->
