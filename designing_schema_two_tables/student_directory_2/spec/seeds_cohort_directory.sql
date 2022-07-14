DROP TABLE IF EXISTS "public"."cohorts" CASCADE;
DROP TABLE IF EXISTS "public"."students" CASCADE;
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS cohorts_id_seq;
CREATE SEQUENCE IF NOT EXISTS students_id_seq;

CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  start_date text
);

-- Then the table with the foreign key first.
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text,
-- The foreign key name is always {other_table_singular}_id
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id) references cohorts(id)
  ON DELETE CASCADE
);

INSERT INTO cohorts ("id", "name", "start_date") VALUES
(1, 'June22', '1 Jun 22'),
(2, 'July22', '1 July 22'),
(3, 'Aug22', '1 August 22');

INSERT INTO students ("id", "name", "cohort_id") VALUES
(1, 'student1', 1),
(2, 'student2', 2),
(3, 'student3', 3),
(4, 'student4', 2);


