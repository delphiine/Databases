CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text
);

-- Create the second table.
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  tag text
);

-- Create the join table.
CREATE TABLE students_tags (
  student_id int,
  tag_id int,
  constraint fk_student foreign key(student_id) references students(id),
  constraint fk_tag foreign key(tag_id) references tags(id),
  PRIMARY KEY (student_id, tag_id)
);