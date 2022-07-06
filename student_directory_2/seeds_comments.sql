CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content text,
  user_name int,
-- The foreign key name is always {other_table_singular}_id
  posts_id int,
  constraint fk_posts foreign key(posts_id) references posts(id)
);