require 'cohort_repository'

def reset_all_tables
    seed_sql = File.read('spec/seeds_cohort_directory.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2' })
    connection.exec(seed_sql)
end

describe CohortRepository do
    before(:each) do 
        reset_all_tables
    end

    it "returns a cohort and its students" do
        repo = CohortRepository.new
        cohort = repo.find_with_students(2)

        expect(cohort.start_date).to eq("1 July 22")
        expect(cohort.name).to eq("July22")
        expect(cohort.students.first.name).to eq("student2")
    end
end