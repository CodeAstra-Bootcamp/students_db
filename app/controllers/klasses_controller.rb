# == Schema Information
#
# Table name: klasses
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class KlassesController < ApplicationController
  def index
    @klasses = Klass.includes(students: [:house]).all
    @new_klass = Klass.new
  end

  def create
    @klass = Klass.new
    @klass.name = params[:klass][:name]
    @save_success = @klass.save
  end

  def analytics
    klass = Klass.find(params[:id])
    sections = klass.sections
    students = Student.where(section_id: sections.pluck(:id)).group_by(&:section_id)
    attendance_registries = AttendanceRegistry.where('date >= ?', Date.today - 14.days).where(section_id: sections.pluck(:id))
    grouped_attendance_registries = attendance_registries.group_by(&:section_id)
    absentees = Absentee.where(attendance_registry_id: attendance_registries.pluck(:id)).group_by(&:attendance_registry_id)
    exams = Exam.where(student_id: students.values.flatten.collect(&:id))

    @attendance_data = []
    sections.each do |section|
      data = {}
      students_count = students[section.id].length
      grouped_attendance_registries[section.id].each do |ar|
        absentees_count = (absentees[ar.id] || []).length
        data[ar.date] = 100*(students_count - absentees_count)/students_count
      end
      @attendance_data.push({name: section.pretty_name, data: data})
    end

    @marks_data = []
    sections.each do |section|
      total_scores = Hash.new(0)
      student_ids = students[section.id].collect(&:id)
      exams.each do |exam|
        if student_ids.include?(exam.student_id)
          [:english, :hindi, :mathematics, :science, :social].each do |subject|
            total_scores[subject] += exam.send(subject)
          end
        end
      end
      students_count = students[section.id].length
      avg_scores = {}
      total_scores.each do |subject, total|
        avg_scores[subject.to_s.capitalize] = total / students_count
      end
      @marks_data.push({name: section.pretty_name, data: avg_scores})
    end 

    #For Percentile distribution
    @percentile_data = Hash.new(Array.new);
    # Calculate the percentage of all student marks
    students = klass.students.includes(:exam)
    percentage_arr = [];
    students.each do |student|
      total_marks = student.exam.total
      percentage = total_marks/5.0  # Subject count to be got dynamically
      # push this into an array
      percentage_arr.push(percentage);
    end

    # Now from the percentage array, get the percentiles
    # 
    students_count = students.count
    grades_hash = Hash.new(0);
    percentage_arr.each do |current_percent|
      students_less_than_current_percent = percentage_arr.count{|percent| percent<=current_percent}
      percentile = 100.0*students_less_than_current_percent/students_count
      grade = get_grade(percentile)
      grades_hash[grade]+=1
      @percentile_data[grade] = grades_hash[grade]; 
    end

  end

private
def get_grade(percentile)
  if (percentile >= 90)
    return "S"
  elsif (percentile >= 80 and percentile < 90)
    return "A"
  elsif (percentile >= 70 and percentile < 80)
    return "B"
  elsif (percentile >= 60 and percentile < 70)
    return "C"
  elsif (percentile >= 50 and percentile < 60)
    return "D"
  elsif (percentile >= 40 and percentile < 50)
    return "E"
  else 
    return "F"  
  end                  
end

end
