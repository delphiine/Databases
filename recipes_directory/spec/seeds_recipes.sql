DROP TABLE IF EXISTS "public"."recipes";

CREATE SEQUENCE IF NOT EXISTS recipes_id_seq;

CREATE TABLE recipes (
  id SERIAL PRIMARY KEY,
  name text,
  cooking_time text,
  rating int
);

INSERT INTO "public"."recipes" ("id", "name", "cooking_time", "rating") VALUES
(1, 'Pizza', '85 min', 4),
(2, 'Pasta', '15 min', 5);