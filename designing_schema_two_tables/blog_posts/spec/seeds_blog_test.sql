DROP TABLE IF EXISTS "public"."posts" CASCADE;
DROP TABLE IF EXISTS "public"."comments" CASCADE;
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS cohorts_id_seq;
CREATE SEQUENCE IF NOT EXISTS comments_id_seq;

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  comment text
);

-- Then the table with the foreign key first.
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content text,
  user_name text,
-- The foreign key name is always {other_table_singular}_id
  posts_id int,
  constraint fk_posts foreign key(posts_id) references posts(id)
);

INSERT INTO posts ("id", "title", "content", "comment") VALUES
(1, 'title1', 'content1', 'comment1'),
(2, 'title2', 'content2', 'comment2'),
(3, 'title3', 'content3', 'comment3');

INSERT INTO comments ("id", "content", "user_name", "posts_id") VALUES
(1, 'content1', 'user_name1', 1),
(2, 'content2', 'user_name2', 2),
(3, 'content3', 'user_name3', 3),
(4, 'content4', 'user_name4', 2);


