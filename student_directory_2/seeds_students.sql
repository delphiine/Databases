CREATE TABLE Students (
  id SERIAL PRIMARY KEY,
  name text,
  cohort int,
-- The foreign key name is always {other_table_singular}_id
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id) references cohorts(id)
);