class Exam < ActiveRecord::Base
  belongs_to :student

  attr_accessor :file

  def total
    # [:english, :hindi, :mathematics, :science, :social].collect do |subject_name|
    #   self.send(subject_name)
    # end.reduce(:+)
    self.english + self.hindi + self.mathematics + self.science + self.social
  end

  def high(subject_name)
    self.student.section.students.collect do |st|
      st.exam.send(subject_name)
    end.max
  end

  def average(subject_name)
    students = self.student.section.students
    total = students.collect do |st|
      st.exam.send(subject_name)
    end.reduce(:+)
    return total / students.count
  end

  def percentile(subject_name)
    score = self.send(subject_name)

    students = self.student.section.students
    less = students.collect do |st|
      st.exam.send(subject_name)
    end.count do |sc|
      sc <= score
    end

    return 100*less/students.count
  end

  def rank(subject_name)
    score = self.send(subject_name)

    students = self.student.section.students
    less = students.collect do |st|
      st.exam.send(subject_name)
    end.count do |sc|
      sc <= score
    end

    return students.count - less + 1
  end
end
