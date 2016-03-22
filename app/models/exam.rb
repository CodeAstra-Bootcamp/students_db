class Exam < ActiveRecord::Base
  belongs_to :student

  attr_accessor :file

  def total
    # [:english, :hindi, :mathematics, :science, :social].collect do |subject_name|
    #   self.send(subject_name)
    # end.reduce(:+)
    self.english + self.hindi + self.mathematics + self.science + self.social
  end

  def stats(subject_name)
    @stats ||= {}
    return @stats[subject_name] if @stats[subject_name]

    my_score = self.send(subject_name)

    students = self.student.section.students.includes(:exam)
    scores = students.collect do |st|
      st.exam.send(subject_name)
    end

    high = scores.max
    average = scores.reduce(:+)/students.count
    less = scores.count do |score|
      score <= my_score
    end
    percentile = 100*less/students.count
    rank = students.count - less + 1

    @stats[subject_name] = {high: high, average: average, percentile: percentile, rank: rank}

    return @stats[subject_name]
  end
end
