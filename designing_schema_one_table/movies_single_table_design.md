## 1. Extract nouns from the user stories or specification

```
As a person who loves movies,
So I can list all my favourite movies
I want to see a list of movies' titles.

As a person who loves movies,
So I can list all my favourite movies
I want to see a list of movies' genres.

As a person who loves movies,
So I can list all my favourite movies
I want to see a list of movies' release year.
```

```
Nouns:

movies, genres, release year
```

## 2. Infer the Table Name and Columns

| Record                | Properties                 |
| --------------------- | -------------------------- |
| movie                 | title, genre, release year |

Name of the table (always plural): `movies` 

Column names: `title`, `genre`, `release_year`

## 3. Decide the column types.

```
id: SERIAL
genre: text
release_year: int
```

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: movies_table.sql

CREATE TABLE movies (
  id SERIAL PRIMARY KEY,
  title text,
  genre text,
  release_year int
);
```

## 5. Create the table.

```bash
psql -h 127.0.0.1 movies_directory < movies_table.sql
```