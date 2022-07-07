# Students Two Tables Design Recipe


## 1. Extract nouns from the user stories or specification

```
As a music lover,
So I can organise my records,
I want to keep a list of albums' titles.

As a music lover,
So I can organise my records,
I want to keep a list of albums' release years.

As a music lover,
So I can organise my records,
I want to keep a list of artists' names.

As a music lover,
So I can organise my records,
I want to know each album's artist.
```

```
Nouns:

students, cohort, student name, cohort name, start date
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                 | Properties                     |
| ---------------------- | -----------------------------  |
| cohort                 | name, start_date, student_name 
| student                | name, cohort

1. Name of the first table (always plural): `Cohorts` 

    Column names: `name`, `start_date`, `student_name`

2. Name of the second table (always plural): `Students` 

    Column names: `name`, `cohort`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: Cohorts
id: SERIAL
name: text
start_date: text
student_name: text

Table: Student
id: SERIAL
name: text
cohort: text
```

## 4. Decide on The Tables Relationship




Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
2. Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

Replace the relevant bits in this example with your own:

```
# EXAMPLE

1. Can one artist have many albums? YES
2. Can one album have many artists? NO

-> Therefore,
-> An artist HAS MANY albums
-> An album BELONGS TO an artist

-> Therefore, the foreign key is on the albums table.
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE Cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  start_date text,
  student_name text,
);

-- Then the table with the foreign key first.
CREATE TABLE Students (
  id SERIAL PRIMARY KEY,
  name text,
  cohort int,
-- The foreign key name is always {other_table_singular}_id
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id) references cohorts(id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 student_directory_2 < seeds_cohorts.sql
psql -h 127.0.0.1 student_directory_2 < seeds_students.sql
```