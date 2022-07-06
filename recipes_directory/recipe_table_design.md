## 1. Extract nouns from the user stories or specification

```
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a food lover,
So I can stay organised and decide what to cook,
I'd like to keep a list of all my recipes with their names.

As a food lover,
So I can stay organised and decide what to cook,
I'd like to keep the average cooking time (in minutes) for each recipe.

As a food lover,
So I can stay organised and decide what to cook,
I'd like to give a rating to each of the recipes (from 1 to 5).
```

```
Nouns:

recipes, names, cooking time, rating
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| recipe                | name, cooking time, rating

Name of the table (always plural): `recipes` 

Column names: `name`, `cooking_time`, `rating`

## 3. Decide the column types.

```
# EXAMPLE:

id: SERIAL
name: text
cooking_time: text
rating: int
```

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: recipes_table.sql

CREATE TABLE recipes (
  id SERIAL PRIMARY KEY,
  name text,
  cooking_time text,
  rating int
);
```

## 5. Create the table.

```bash
psql -h 127.0.0.1 recipe_list < recipes_table.sql
```