require_relative './student'
require_relative './cohort'

class CohortRepository
  def find_with_students(cohort_id)
    sql = 'SELECT cohorts.id AS cohort_id, 
                  cohorts.start_date AS cohort_start_date, 
                  cohorts.name AS cohort_name,
                  students.id AS student_id, 
                  students.name AS student_name
            FROM cohorts
            JOIN students
            ON cohorts.id = students.cohort_id
            WHERE cohorts.id = $1;'
    params = [cohort_id]

    result_set = DatabaseConnection.exec_params(sql, params)
    result = result_set[0]

    cohort = Cohort.new
    cohort.id = result["cohort_id"]
    cohort.start_date = result["cohort_start_date"]
    cohort.name = result["cohort_name"]

    result_set.each do |record|
        student = Student.new
        student.id = record["student_id"]
        student.name = record["student_name"]
        cohort.students << student
    end
    return cohort
  end
end