class Cohort
    attr_accessor :id, :name, :start_date, :students
  
    def initialize
      @students = []
    end
  end