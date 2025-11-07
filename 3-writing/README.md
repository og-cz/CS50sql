# Writing

# Table of Contents

- [Writing](#writing)
- [QUICK SUMMARY](#quick-summary)
- [Museum of fine arts](#museum-of-fine-arts)
  - [Prerequisite](#prerequisite)
- [INSERTING](#inserting)
  - [multiple insert](#multiple-insert)
- [IMPORTING](#importing)
  - [.import - -csv - -skip 1 file_name.csv tablename](#import---csv---skip-1-file_namecsv-tablename)
  - [.import - -csv file_name.csv temp](#import---csv-file_namecsv-temp)
- [INSERT INTO table0 (column0, …) SELECT column0, … FROM table1](#insert-into-table0-column0--select-column0--from-table1)
- [DELETING](#deleting)
  - [DELETE FROM table WHERE condition](#delete-from-table-where-condition)
  - [multiple deletes](#multiple-deletes)
- [FOREIGN KEY CONSTRAINTS](#foreign-key-constraints)
  - [FOREIGN KEY("id") REFERENCES table("id") ON DELETE…](#foreign-keyid-references-tableid-on-delete)
- [UPDATING](#updating)
  - [UPDATE table SET column0 = value0, … WHERE condition](#update-table-set-column0--value0---where-condition)
  - [trim](#trim)
  - [upper](#upper)
  - [typo fixing](#typo-fixing)
  - [like typo fixing](#like-typo-fixing)
- [TRIGGERS](#triggers)
  - [Basic Trigger Declaration](#basic-trigger-declaration)
  - [Before Insert](#before-insert)
  - [Before Update of a Specific Column](#before-update-of-a-specific-column)
  - [Before Delete](#before-delete)
  - [After Delete](#after-delete)
  - [OLD and NEW (Inside Triggers)](#old-and-new--inside-triggers)
  - [Example: Log Every Deletion](#example-log-every-deletion)
- [SOFT DELETIONS](#soft-deletions)
- [SUMMARY INTUITION](#summary-intuition)
  - [MUSEUM OF FINE ARTS (SQL BASICS)](#museum-of-fine-arts-sql-basics)
  - [CREATE (INSERT)](#create-insert)
  - [MULTIPLE INSERTS](#multiple-inserts)
  - [IMPORTING DATA (CSV)](#importing-data-csv)
  - [DELETE](#delete)
  - [FOREIGN KEY CONSTRAINTS (summary)](#foreign-key-constraints-summary)
  - [UPDATE (summary)](#update-summary)
  - [TEXT FIXING FUNCTIONS](#text-fixing-functions)
  - [TRIGGERS (summary)](#triggers-summary)
  - [SOFT DELETIONS (summary)](#soft-deletions-summary)
  - [QUICK SUMMARY](#quick-summary-1)

## Museum of fine arts

- this has some artificats and its worth asking some data

we can do ask this 4

- CREATE, READ, UPDATE, DELETE
  ![image.png](attachment:9bd7878d-0888-4c3e-a2fe-e20c2cb260a2:image.png)
  - if we wanna add new rows we can use insert into
  - column0 = value0

![image.png](attachment:95f9138d-07ad-4ff8-a16f-3ac6322a374f:image.png)

**prerequisite:**

```sql
sqlite3 mfa.db -> create database
.schema -> check if it has some tables inside

-- created a table of 4 columns
CREATE TABLE collections (
	"id" INTEGER,
	"title" TEXT NOT NULL,
	"accession_number" TEXT NOT NULL UNIQUE,
	"acquired" NUMERIC,
	PRIMARY KEY("id")
);

```

## INSERTING

In SQL, "inserting" means adding one or more new rows (records) into a table. You use the INSERT INTO statement to specify the target table, which columns you provide values for, and the values themselves.

1. first insert the order of data
   - INSERT INTO collections ("id","title","accession_number","acquired")
2. create the value to be inserted based of the order
   - VALUES (1, 'Profusion of flowers', '56.257', '1956-04-12');

```sql
INSERT INTO collections ("id","title","accession_number","acquired")
VALUES (1, 'Profusion of flowers', '56.257', '1956-04-12');
```

BUT THIS IS NOT SAFE WHAT IF OUR ID IS A PRIMARY KEY? THEN IT CAUSE DUPLICATION WHICH IS NOT GOOD

- in SQLITE we can do is not include id it will automatiaclly do it for us

```sql
INSERT INTO collections ("title", "accession_number", "acquired")
VALUES ('Spring outing', '14.76', '1914-01-08');

-- OUTPUT
1|Profusion of flowers|56.257|1956-04-12
2|Framers working at dawn|11.6152|1911-08-03
3|Spring outing|14.76|1914-01-08

```

### multiple insert

- more optimize way of inserting alot of values

INSERT INTO table (column0,…)

VALUES

(Value0, …),

(Value1, …),

…;

## IMPORTING

what if we already have a data let say CSV - comma seperated values

![image.png](attachment:005a1a85-981b-4807-a5af-431df9f8e4e2:image.png)

and we want to quickly import our data ITS A SQLITE COMMAND

### .import - -csv - -skip 1 file_name.csv tablename

- - -csv → to say we are importing a csv
- **- -skip1 → dont include first row | why? becuase we dont wanna import id,title,accession_number,acquired**
- file_name.csv → what csv file to read
- tablename → where table to put the data

```sql
.import --csv --skip 1 csv_file_name.csv tablename
```

BUT WHAT IF THE CURRENT DATABASE ALREADY HAVE A DATA SPECIALLY THE PRIMARY KEY ID MIGHT CLASH ON THE NEW IMPORT?

let say we have this data and this schema:

![image.png](attachment:1569d767-3f3b-4733-a406-3f626da8ebba:image.png)

```sql
.schema
CREATE TABLE collections (
        "id" INTEGER,
        "title" TEXT NOT NULL,
        "accession_number" TEXT NOT NULL UNIQUE,
        "acquired" NUMERIC,
        PRIMARY KEY("id")
);
```

- removing id would cause us error, but waht we can do is import this data into a temporary table nad insert that data in our real table
- we can do .import and insert into

### .import - -csv file_name.csv temp

created a brand new table temp

```sql
.import --csv --skip 1 mfa-importing.csv temp

.schema
CREATE TABLE IF NOT EXISTS "temp"(
"Profusion of flowers" TEXT, "56.257" TEXT, "1956-04-12" TEXT);

SELECT * FROM temp;
Farmers working at dawn|11.6152|1911-08-03
Spring outing|14.76|1914-01-08
Imaginative landscape|56.496|
Peonies and butterfly|06.1899|1906-01-01
```

### INSERT INTO table0 (column0, …) SELECT column0, … FROM table1

- basically its just a way for us to insist our own formatting of schema the way to do it just import the whole csv in a temp table then impor the data inside using select and there we ahve imported sucessfuly the data

```sql
INSERT INTO collections ("title", "accession_number", "acquired")
SELECT "title", "accession_number", "acquired" FROM temp;

sqlite> SELECT * FROM collections;
1|Profusion of flowers|56.257|1956-04-12
2|Farmers working at dawn|11.6152|1911-08-03
3|Spring outing|14.76|1914-01-08
4|Imaginative landscape|56.496|
5|Peonies and butterfly|06.1899|1906-01-01

DROP TABLE temp;
```

NOTE: everything imported from CSV → always returns a text so if there is a blank value then we can only UPDATE It to make it a NULL value

## DELETING

if we can insert some rows, we can also delete it

### DELETE FROM table WHERE condition

- doing DELETE FROM table only might drop everything
- but doing WHERE can help us select
  ```
  DELETE FROM collections
  WHERE "title" = 'Spring outing';
  ```

### multiple deletes

just apply a condition where it scopes that all

```jsx
DELETE FROM collections
WHERE "acquired" < '1909-01-01';
```

## FOREIGN KEY CONSTRAINTS

IT MEANS we have some table referenced by other table, but if we are about to delte that primary key that foreign key will have no reference

![image.png](attachment:653d7bfe-2f38-4526-8cb2-632d4eff8f67:image.png)

![image.png](attachment:f6d931b1-2a5f-4ace-a9f5-753a5707ed2c:image.png)

- let say we deleted uninditied artists in artists table

![image.png](attachment:6041e277-ab3a-48ce-b2fc-a4e37a3aa33e:image.png)

- we cannot undestand where its relating to…

### FOREIGN KEY(”id”) REFERENCES table(”id”) ON DELETE…

is a way to delete a foreign key in a faster way in using built in commands

`ON DELETE ...` is a built-in mechanism that tells the database **how to handle related foreign key rows automatically** when a parent (referenced) row is deleted.

**FOREIGN KEY(”id”) REFERENCES table(”id”) ON DELETE RESTRICT**

✅ Same as `NO ACTION` — it **prevents deletion** of the parent if any children reference it.

🧠 Think: “Restriction: no delete allowed while children exist.”

**FOREIGN KEY(”id”) REFERENCES table(”id”) ON DELETE NO ACTION**

✅ The database will **not let you delete** the parent **if child rows exist** that reference it.

- You must delete the child rows manually first.
- If you try to delete the parent, it will throw an **error**.

🧠 **T**hink: “No action → I refuse to delete if children still exist

**FOREIGN KEY(”id”) REFERENCES table(”id”) ON DELETE SET NULL**

✅ Deletes the **parent**, and sets the foreign key column in all referencing child rows to **NULL**.

- The children remain in the table.
- But their foreign key column now becomes `NULL` — meaning they’re **no longer linked** to any parent.

🧠 Think: “Parent gone → children stay, but now have no parent.”

**FOREIGN KEY(”id”) REFERENCES table(”id”) ON DELETE SET DEFAUL**

✅ Deletes the **parent**, and for any child rows that referenced it,

the foreign key column is changed to its **default value** (whatever you defined in the table).

- The child rows are **not deleted** — they stay in the table.
- Their foreign key column is just replaced with the default value (e.g. `0`, `'N/A'`, or another valid ID).

🧠 Think: “Parent gone → children stay, but their link resets to default.”

**FOREIGN KEY(”id”) REFERENCES table(”id”) ON DELETE CASCADE**

✅ **Deletes the parent AND all related child rows automatically.**

- If you delete the parent (the main row with the primary key),
  → all foreign key rows (the children) that reference it are **also deleted automatically**.
- It **does not** delete the parent first — it starts with the parent and cascades the delete to children.

🧠 Think: “Delete one → delete all connected.”

## UPDATING

we know see how to insert and delete it, but soemtime we just wanna change the value like some typo

## UPDATE table SET column0 = value0, … WHERE condition

```jsx
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition;
```

- `UPDATE table_name` → tells SQL which table you want to modify.
- `SET` → specifies which columns to change and what their new values should be.
- `WHERE` → filters which rows get updated (⚠️ if you leave it out, **all rows** in the table will be updated!).

### trim

- removing trailing and leading whitespace

```jsx
UPDATE "votes"
SET "title" = trim("title");
```

### upper

- converts text to capital letter

```jsx
UPDATE "votes"
SET "title" = upper("title");
```

### typo fixing

```jsx
UPDATE votes
SET "title" = 'FARMERS WORKING AT DAWN'
WHERE "title" = 'FARMERS WORKING';

UPDATE votes
SET "title" = 'FARMERS WORKING AT DAWN'
WHERE "title" = 'FAMERS WORKING AT DAWN';

UPDATE votes
SET "title" = 'FARMERS WORKING AT DAWN'
WHERE "title" = 'FARMESR WORKING AT DAWN';
```

BUT DOING THIS IS TOO HEAVY IF ITS A MILLLION DATA SO WE CAN USE IS LIKE

### like typo fixing

```sql
-- its a bit cleaner, but what if this is a thousands of data better to use LIKE
-- GROUP BY "title";
-- FARMERS WORKING AT DAWN|6
-- IMAGINATIVE  LANDSCAPE|1
-- IMAGINATIVE LANDSCAPE|3
-- IMAGINTIVE LANDSCAPE|1
-- PROFUSION|1
-- PROFUSION OF FLOWERS|3
-- SPRING OUTING|5

UPDATE votes
SET "title" = 'IMAGINATIVE LANDSCAPE'
WHERE "title" LIKE 'IMAGI%';

NOW ITS LIKE THIS FAR BETTER !

-- FARMERS WORKING AT DAWN|6
-- IMAGINATIVE LANDSCAPE|5
-- PROFUSION|1
-- PROFUSION OF FLOWERS|3
-- SPRING OUTING|5
```

## TRIGGERS

wouldn`t it be nice if we have something deleted, it would show up in transaction we could do that using triggers

![image.png](attachment:6cce07fc-5b51-4b54-943b-b52d7cce9055:image.png)

and if we delete the id 4, with trigger when its deleted we can see it in transaction table

![image.png](attachment:47ff3412-3781-4a34-97e8-452b517a9f70:image.png)

and if we add another one again, and if we ahve a appropriate trigger it will be like this:

![image.png](attachment:91ef6211-be5f-435e-919a-e9ef2b4dcaa7:image.png)

A **trigger** automatically runs a block of SQL code **when an event occurs** (like `INSERT`, `UPDATE`, or `DELETE`) on a table.

🔹 **1. Basic Trigger Declaration**

```sql
CREATE TRIGGER trigger_name
timing event ON table_name
FOR EACH ROW
BEGIN
    -- actions go here
END;

```

| Part             | Meaning                                                         |
| ---------------- | --------------------------------------------------------------- |
| **trigger_name** | The name of your trigger                                        |
| **timing**       | `BEFORE` or `AFTER` (when to run relative to the event)         |
| **event**        | `INSERT`, `UPDATE`, or `DELETE`                                 |
| **table_name**   | The table to watch                                              |
| **FOR EACH ROW** | Runs once for every affected row (required in most SQL systems) |

🔹 **2. Create a Trigger (Generic)**

```sql
CREATE TRIGGER trigger_name;

```

> Just the declaration (not valid alone) you must specify when and on which table it triggers.

🔹 **3. Before Insert**

```sql
CREATE TRIGGER trigger_name
BEFORE INSERT ON table_name
FOR EACH ROW
BEGIN
    -- runs before a new row is inserted
END;

```

🧩 Example: Check or modify data before it’s inserted.

🔹 **4. Before Update of a Specific Column**

```sql
CREATE TRIGGER trigger_name
BEFORE UPDATE OF column_name ON table_name
FOR EACH ROW
BEGIN
    -- runs before column_name is updated
END;

```

🧩 Example: Automatically update a “last_modified” timestamp before an update.

🔹 **5. Before Delete**

```sql
CREATE TRIGGER trigger_name
BEFORE DELETE ON table_name
FOR EACH ROW
BEGIN
    -- runs before a row is deleted
END;

```

🧩 Example: Save deleted data into a backup or log table before it’s gone.

🔹 **6. After Delete**

```sql
CREATE TRIGGER trigger_name
AFTER DELETE ON table_name
FOR EACH ROW
BEGIN
    -- runs after a row is deleted
END;

```

🧩 Example: Log or cascade other actions _after_ deletion.

💡 Inside Triggers — `OLD` and `NEW`

| Event    | Access                                       |
| -------- | -------------------------------------------- |
| `INSERT` | only `NEW.column_name`                       |
| `UPDATE` | both `OLD.column_name` and `NEW.column_name` |
| `DELETE` | only `OLD.column_name`                       |

✅ Example: Log Every Deletion

```sql
CREATE TRIGGER log_user_delete
AFTER DELETE ON users
FOR EACH ROW
BEGIN
  INSERT INTO logs (message)
  VALUES ('User deleted with ID: ' || OLD.id);
END;

```

## SOFT DELETIONS

instead of actually deleting a record from the database, you just mark it as deleted but keep it in the table So it’s “deleted” _logically_, not _physically_.

![image.png](attachment:f1981a0d-7302-4756-b497-582e6286d97b:image.png)

- so if we mark it as deleted it look like this:
  ![image.png](attachment:e090607c-dbdc-46ff-992b-97f91b67677e:image.png)
- but in our .schema there is no deleted table but we can do alter table
  ```sql
  CREATE TABLE IF NOT EXISTS "collections" (
      "id" INTEGER,
      "title" TEXT NOT NULL,
      "accession_number" TEXT NOT NULL UNIQUE,
      "acquired" NUMERIC,
      PRIMARY KEY("id")
  );
  ```
  we do this because in some data we don`t want to fully delete something that is important so it depends on the design if we are dropping it or soft deleting it

```sql
-- SOFT DELETIONS
ALTER TABLE collections
ADD COLUMN
    "deleted" INTEGER DEFAULT 0;

SELECT * FROM collections;
-- 1|Farmers working at dawn|11.6152|1911-08-03|0
-- 2|Imaginative landscape|56.496||0
-- 4|Spring outing|14.76|1914-01-08|0
-- 5|Profusion of flowers|56.247|1956-04-12|0

UPDATE collections
SET "deleted" = 1
WHERE "title" = 'Farmers working at dawn';

SELECT * FROM collections WHERE deleted != 1;
-- 2|Imaginative landscape|56.496||0
-- 4|Spring outing|14.76|1914-01-08|0
-- 5|Profusion of flowers|56.247|1956-04-12|0
```

# SUMMARY INTUITION

### MUSEUM OF FINE ARTS (SQL BASICS)

This section teaches the **core CRUD operations** —

**Create, Read, Update, Delete** and how data behaves in a real-world example (like managing museum collections).

---

### CREATE (INSERT)

- Used to **add new rows** to a table.
- You can **insert** all columns or skip `id` if it’s `INTEGER PRIMARY KEY` (auto-numbered).

```sql
INSERT INTO collections ("title", "accession_number", "acquired")
VALUES ('Spring outing', '14.76', '1914-01-08');

```

✅ SQLite automatically assigns an `id`.

---

### MULTIPLE INSERTS

- Add several rows in one command (faster):

```sql
INSERT INTO collections ("title", "accession_number", "acquired")
VALUES
('Profusion of Flowers', '56.257', '1956-04-12'),
('Farmers Working at Dawn', '11.6152', '1911-08-03');

```

---

### IMPORTING DATA (CSV)

If you already have a dataset (like a CSV file), use:

```sql
.import --csv --skip 1 file.csv tablename

```

- `-csv` → importing CSV format
- `-skip 1` → skip header row
- `file.csv` → your CSV file
- `tablename` → target table

💡 If your schema doesn’t match the CSV,

import into a **temporary table** and then:

```sql
INSERT INTO collections (title, accession_number, acquired)
SELECT title, accession_number, acquired FROM temp;
DROP TABLE temp;

```

---

### DELETE

Removes data from a table.

```sql
DELETE FROM collections WHERE title = 'Spring outing';

```

Without `WHERE`, it deletes **all rows**.

Example for multiple deletions:

```sql
DELETE FROM collections WHERE acquired < '1909-01-01';

```

---

### FOREIGN KEY CONSTRAINTS

A **foreign key** links one table’s column to another table’s primary key.

If you delete a parent row, what happens to its children depends on `ON DELETE` rules.

| Rule                     | Behavior                                     | Intuition                                            |
| ------------------------ | -------------------------------------------- | ---------------------------------------------------- |
| `RESTRICT` / `NO ACTION` | Block deletion if children exist             | “You can’t delete parents if kids are still linked.” |
| `SET NULL`               | Delete parent → children’s FK becomes `NULL` | “Parent gone, kids stay but orphaned.”               |
| `SET DEFAULT`            | FK replaced by default value                 | “Parent gone, kids reset to default.”                |
| `CASCADE`                | Delete parent → delete all linked children   | “Delete one → delete all related.”                   |

---

### UPDATE

Used to **change values** in rows.

```sql
UPDATE collections
SET title = 'Spring Outing (1914)'
WHERE id = 3;

```

Without `WHERE`, all rows update.

---

### TEXT FIXING FUNCTIONS

- `trim(text)` → removes spaces
- `upper(text)` → converts to uppercase

```sql
UPDATE votes SET title = trim(title);
UPDATE votes SET title = upper(title);

```

Use `LIKE` for mass typo fixes:

```sql
UPDATE votes
SET title = 'IMAGINATIVE LANDSCAPE'
WHERE title LIKE 'IMAGI%';

```

---

### TRIGGERS

A **trigger** automatically runs SQL code when something happens

(like insert, update, or delete).

**Syntax:**

```sql
CREATE TRIGGER trigger_name
AFTER DELETE ON table_name
FOR EACH ROW
BEGIN
    -- actions go here
END;

```

| Timing   | Description                                        |
| -------- | -------------------------------------------------- |
| `BEFORE` | Runs before the event (can modify or cancel it)    |
| `AFTER`  | Runs after the event (used for logging or actions) |

**Special variables:**

- `NEW.column` → new value (INSERT/UPDATE)
- `OLD.column` → old value (DELETE/UPDATE)

💡 Example: Log deleted users

```sql
CREATE TRIGGER log_user_delete
AFTER DELETE ON users
FOR EACH ROW
BEGIN
  INSERT INTO logs (message)
  VALUES ('Deleted user ID: ' || OLD.id);
END;

```

---

### SOFT DELETIONS

Instead of removing a row, **mark it as deleted** but keep it in the table.

Add a `deleted` column:

```sql
ALTER TABLE collections ADD COLUMN deleted INTEGER DEFAULT 0;

```

Mark as deleted:

```sql
UPDATE collections SET deleted = 1 WHERE title = 'Farmers working at dawn';

```

Show only active data:

```sql
SELECT * FROM collections WHERE deleted = 0;

```

Think of it like a **Recycle Bin** — the data isn’t gone, just hidden.

---

### QUICK SUMMARY

| Concept           | Meaning                       |
| ----------------- | ----------------------------- |
| INSERT            | Add new rows                  |
| IMPORT            | Bring data from CSV           |
| DELETE            | Remove rows                   |
| UPDATE            | Modify rows                   |
| TRIGGER           | Auto-run SQL on event         |
| FOREIGN KEY       | Link tables                   |
| ON DELETE CASCADE | Delete all linked rows        |
| SOFT DELETE       | Mark as deleted (not removed) |
