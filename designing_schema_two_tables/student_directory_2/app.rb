require_relative 'lib/database_connection'
require_relative 'lib/cohort_repository'


DatabaseConnection.connect('student_directory_2')

repo = CohortRepository.new
cohort = repo.find_with_students(2)

puts "The #{cohort.name} cohort starts #{cohort.start_date}."
cohort.students.each do |student|
    puts student.name
end