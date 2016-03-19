class Exam < ActiveRecord::Base
  belongs_to :student

  attr_accessor :file

  def high(subject_name)
    self.student.section.students.collect do |st|
      st.exam.send(subject_name)
    end.max
  end
end
