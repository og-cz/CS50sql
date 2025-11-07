# Designing

- [Designing](#designing)
- [MBTA](#mbta)
- [Schema](#schema)
- [Normalizing](#normalizing)
- [Relating](#relating)
- [CREATE TABLE keyword](#create-table-keyword)
- [TABLE OF VISITS](#table-of-visits)
- [.schema](#schema-1)
- [Data types and Storage Classes](#data-types-and-storage-classes)
  - [INTEGER](#integer)
  - [Example of values](#example-of-values)
  - [Type Affinities](#type-affinities)
- [DROP TABLE Keyword](#drop-table-keyword)
- [.read command](#read-command)
- [Table Constraints](#table-constraints)
  - [rowid in sqlite3](#rowid-in-sqlite3)
  - [INTEGER PRIMARY KEY vs PRIMARY KEY("id")](#integer-primary-key-vs-primary-keyid)
- [Column Constraints](#column-constraints)
- [Altering Tables](#altering-tables)
  - [DROP TABLE …](#drop-table-)
  - [ALTER TABLE …](#alter-table-)
  - [ADD COLUMN …](#add-column-)
  - [RENAME COLUMN … TO …](#rename-column--to-)
  - [DROP COLUMN …](#drop-column-)
  - [RENAME TO …](#rename-to-)
- [CURRENT_TIMESTAMP special keyword](#current_timestamp-special-keyword)
- [SUMMARY INTUITION](#summary-intuition)
  - [DATABASE DESIGN](#database-design)
  - [KEYS](#keys)
  - [RELATIONSHIPS](#relationships)
- [Quick Note](#quick-note)
- [SPECIAL KEYWORDS](#special-keywords)
- [QUICK SUMMARY](#quick-summary)

## Designing

Designing our own database schema to organize our data

```sql
.schema
```

.schema is to show what query used to create that table

### mbta

**Massachusetts Bay Transportation Authority**

Boston is famous to first have a subway in the USA, you can go to harvard or mit or south whatever,

![image.png](attachment:0d1d2d63-ae3f-4759-a5be-60f33933d6d4:image.png)

now if we are goign to create a table of people who uses this train what is a good schema to do?

### schema

what kinds of column do we put, or waht data should we put it in columns for instance

![image.png](attachment:88ce0178-7f47-43d6-9ef7-0225e0244c3c:image.png)

what more could we have? or hwat is charlie doing in that station and its fare

![image.png](attachment:b2bdc31c-8373-4470-a929-16898425831a:image.png)

it seems good but the authority in a transit we want to know does charlie could ahve enough money so we have to put balance

![image.png](attachment:faabc2b6-7596-41dc-adac-6b8376dd2e4e:image.png)

and after that he goes off on jamaica plain

![image.png](attachment:819b3667-700b-4862-b83b-1ee42ac608d0:image.png)

**then if we would put more data**

![image.png](attachment:aa4742b3-0570-476f-b060-a1ff3da1c880:image.png)

but there are missing like primary keys the foreign keys

![image.png](attachment:d43ae8e0-eda7-40e2-9b62-e9cbe325d461:image.png)

but this could be improve substiantally?

what do u think?

**the names can be imrpoved because we might have duplicate name of different person**

![image.png](attachment:efd4d70d-6714-4cd3-acdd-23faf1320ac9:image.png)

![image.png](attachment:0caeefa9-6493-4d4b-9bd9-e4dbc7650651:image.png)

so creating this self tables are called normalizing

### normalizing

to normalize is to reduce redundancy, to make a table to split into multiple and have each entity have its own table

some academics in the world have this so called normal forms, like first, second what so ever

### relating

in the topic last time, how could we relate this altogehter?

![image.png](attachment:89d29d6b-a2d0-4b9f-b829-9ad00507db23:image.png)

then we know a rider can go in one station but can also get off and go on another station

![image.png](attachment:3ad79830-65a4-44b9-a1a5-64e6a6fd3b61:image.png)

to put in our language of ER diagram from last week we can say something lkie this:

![image.png](attachment:aa44ef5d-e6c3-4fd7-99e0-39069d4f36c8:image.png)

- rider to station can go one or many station
- station to rider can go zero or many riders

## CREATE TABLE keyword

allows us to create a new table

```sql
-- creating a brand new database
sqlite3 mbta.db

-- creating table for RIDER
CREATE TABLE riders (
    "id",
    "name"
);

-- creating table for STATIONS
CREATE TABLE stations (
    "id",
    "name",
    "line"
);
```

### **TABLE OF VISITS**

```sql
-- to have a relation on the two table
CREATE TABLE visits (
    "rider_id",
    "station_id"
);
```

- `riders` = list of people
- `stations` = list of places
- `visits` = the _story of what happened between them_

### **.schema**

```sql
sqlite> .schema
-- outputs!
CREATE TABLE riders (
    "id",
    "name"
);
CREATE TABLE stations (
    "id",
    "name",
    "line"
);
CREATE TABLE visits (
    "rider_id",
    "station_id"
);
```

### **why dind`t we use just primary key and foreign key for the two data?**

- Foreign keys can only link one-to-one or one-to-many. You need a third (bridge) table like visits to represent many-to-many relationships without duplication or data loss.

**AND LOOKING AT OUR TABLE IN .schema THERE IS MISSING PARTS**

## Data types and Storage Classes

sqlite3 has 5 types of storage classes

- NULL → nothing inside
- INTEGER → a whole number like 1,2,3
- REAL → talks about decimals like 0.1,0.2,0.3
- TEXT → about characters
- BLOB → binary large object, represent data exactly as its like a structure we dont wanna mess around like images

### INTEGER

it can hold several 7 data types 0 to 8 bytes of integer, it uses its appropriate data type if we use quintiellion number of value it prob use 8 byte

![image.png](attachment:fbb0e9d7-9b95-45dc-9966-545be72a40d3:image.png)

### example of values

- “Red Line” as some characeters so we can use TEXT class
- we can use BLOB for images to keep exact pixels as it is
  ![image.png](attachment:e46a7e94-da16-49e1-8f28-9e3f01bfb141:image.png)
- trades off for INTEGER, REAL, OR TEXT
  - 10 → it our previous example as FARE are we reffering to what currency?
  - $0.10 → this is better tho there is some downside to this, and we cant do math with text
  - 0.10 → we can use decimal but can get wonky if we have 0.10000000095959

### Type Affinities

When you insert a value into a column, SQLite tries to **convert it to the column’s affinity type**

or its like dynamically type like python

for example

1. we have an id → integer and amount → string
2. we inserted amount of 10 → integer
3. it turns it into string taht look like this:

   ![image.png](attachment:98c26067-01a6-445c-bf6f-72bdbba37774:image.png)

4. if we do opposite now amount → integer type and we input a “10” it will look like this:

   ![image.png](attachment:4bf99f72-8aea-48cc-acaa-c7f4b8981805:image.png)

## DROP TABLE Keyword

DROP TABLE table_name;

- removes table from the database

### .read command

if we create a .sql file we can put a command we want and if we want to apply taht in any database we can do

```sql
.read query.sql -- applies to the database we are on
```

## Table Constraints

This mean some value have to be a certain way like primary keys can be only unique, it cannot repeat

- PRIMARY KEY
- FOREIGN KEY

  ```sql
  CREATE TABLE riders (
      "id" INTEGER,
      "name" TEXT,
      PRIMARY KEY("id")
  );

  CREATE TABLE stations (
      "id" INTEGER,
      "name" TEXT,
      "line" TEXT,
      PRIMARY KEY("id")
  );

  CREATE TABLE visits (
      "rider_id" INTEGER,
      "station_id" INTEGER,
      FOREIGN KEY("rider_id") REFERENCES riders("id"),
      FOREIGN KEY("station_id") REFERENCES stations("id")
  );
  ```

**rowid in sqlite3**

- Every SQLite table **automatically** has a hidden column called **`rowid`**.
- It’s like a **unique number** that identifies each row in the table.

### INTEGER PRIMARY KEY vs PRIMARY KEY(”id”)

- `id INTEGER PRIMARY KEY` → replaces `rowid`, auto-numbers rows, faster and preferred
- `id INTEGER, PRIMARY KEY(id)` → keeps hidden `rowid` + your own `id`, not auto-numbered.

## Column Constraints

a column constrains applies to a particular column, let say we have a column have a particular value like no value must be NOT NULL what so ever…

- CHECK → allows us to check to be sure if this amount is greater than 0
- DEFAULT → if no value is inserted we can have default value
- NOT NULL → we cant insert empty values and required
- UNIQUE → every row is unique value, it can appear twice

**AND COLUMN CONSTRIANTS ARE GOOD TO APPLY A DATA THAT IS NOT A PRIMARY NOR A FOREIGN KEY**

## Altering Tables

we know that we have riders, station, visit table but we could learn query to update our table we have

![image.png](attachment:bf575afd-7cf3-44be-a6cc-fcc460c180df:image.png)

### DROP TABLE …

- deleting a table
  ```sql
  DROP TABLE students;
  ```

### ALTER TABLE …

- we can use this to modify a table
  ```sql
  ALTER TABLE students RENAME TO alumni;
  ```

### ADD COLUMN …

- add a new column to a table
  ```sql
  ALTER TABLE students ADD COLUMN age INTEGER;
  ```

### RENAME COLUMN … TO …

- Renames a specific column to any table
  ```sql
  ALTER TABLE students RENAME COLUMN name TO full_name;
  ```

### DROP COLUMN …

- Removes a column from a table.
  ```sql
  ALTER TABLE students DROP COLUMN age;
  ```

### RENAME TO …

- Renames a table or a column
  ```sql
  ALTER TABLE students RENAME TO learners;
  ALTER TABLE students RENAME COLUMN name TO full_name;
  ```

### CURRENT_TIMESTAMP special keyword

special keyword in sql that creates a current time if we dont input something

```sql
CREATE TABLE cards (
    "id" INTEGER,
    PRIMARY KEY("id")
);

CREATE TABLE stations (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "line" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE swipes (
    "id" INTEGER,
    "card_id" INTEGER,
    "station_id" INTEGER,
    "type" TEXT NOT NULL CHECK("type" IN ('enter', 'exit', 'deposit')),             -- only choose type inside our own conditions
    "datetime" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,                          -- special keyword in sql that creates a curent time if we dont input something
    "amount" NUMERIC NOT NULL CHECK("amount" != 0),                                 -- value must not be equal to 0
    PRIMARY KEY("id"),
    FOREIGN KEY("card_id") REFERENCES cards("id"),
    FOREIGN KEY("station_id") REFERENCES stations("id")
);
```

# SUMMARY INTUITION

### DATABASE DESIGN

- **Schema** – Blueprint of how data is organized in tables and columns.
- **Normalization** – Breaking big tables into smaller related ones to remove duplication.
- **Relationship** – How tables connect (one-to-one, one-to-many, many-to-many).

---

### KEYS

- **PRIMARY KEY** – Unique ID for each record (no duplicates, no NULL).
- **FOREIGN KEY** – References a primary key in another table to build relationships.
- **ROWID** – Hidden unique number SQLite gives automatically to every row.
- **INTEGER PRIMARY KEY** – Replaces `rowid`, auto-numbers rows, faster and preferred.
- **PRIMARY KEY(id)** – Keeps both `rowid` and `id`, not auto-numbered.

**Quick Note:**

`INTEGER PRIMARY KEY` → automatic numbering (recommended).

`PRIMARY KEY(id)` → manual ID, `rowid` still exists.

---

### RELATIONSHIPS

- **One-to-One** – One record matches one record in another table.
- **One-to-Many** – One record connects to multiple in another table.
- **Many-to-Many** – Requires a bridge table.

Example:

```sql
CREATE TABLE visits (
    rider_id INTEGER,
    station_id INTEGER,
    FOREIGN KEY(rider_id) REFERENCES riders(id),
    FOREIGN KEY(station_id) REFERENCES stations(id)
);

```

---

### DATA TYPES

- **NULL** – No value.
- **INTEGER** – Whole numbers.
- **REAL** – Decimal numbers.
- **TEXT** – Strings or characters.
- **BLOB** – Binary data (e.g. images).

SQLite automatically converts inserted values to fit the column type.

---

### COLUMN CONSTRAINTS

- **NOT NULL** – Value must be provided.
- **UNIQUE** – No duplicate values allowed.
- **CHECK** – Ensures a condition is met (e.g., `CHECK(age > 0)`).
- **DEFAULT** – Auto-fills a value if none is given.

---

### TABLE CONSTRAINTS

- Apply to multiple columns or the entire table.
- Examples:
  - `PRIMARY KEY(id)`
  - `FOREIGN KEY(user_id) REFERENCES users(id)`

---

### ALTERING TABLES

- `DROP TABLE students;` – Deletes a table.
- `ALTER TABLE students ADD COLUMN age INTEGER;` – Adds a column.
- `ALTER TABLE students DROP COLUMN age;` – Removes a column.
- `ALTER TABLE students RENAME COLUMN name TO full_name;` – Renames a column.
- `ALTER TABLE students RENAME TO learners;` – Renames the table.

---

### SPECIAL KEYWORDS

- **CURRENT_TIMESTAMP** – Automatically sets current date & time for new rows.
- **.schema** – Shows how tables were created.
- **.read file.sql** – Runs SQL commands from a file.

---

### QUICK SUMMARY

| Concept             | Meaning                  |
| ------------------- | ------------------------ |
| Schema              | Database blueprint       |
| Normalization       | Remove data repetition   |
| Primary Key         | Unique identifier        |
| Foreign Key         | Connects tables          |
| INTEGER PRIMARY KEY | Auto-numbered ID         |
| Constraints         | Rules for data integrity |
| ALTER TABLE         | Modify existing tables   |
| .schema             | Show table definitions   |
