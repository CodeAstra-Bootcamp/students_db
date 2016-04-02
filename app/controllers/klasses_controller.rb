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
    @klass = Klass.find(params[:id])

    # Attendance Data
    @attendance_data = []
    @klass.sections.each do |section|
      data = {}
      students_count = section.students.count
      attendance_registries = section.attendance_registries.includes(:absentees)
      attendance_registries.each do |ar|
        data[ar.date] = 100*(students_count - ar.absentees.count)/students_count
      end
      @attendance_data.push({name: "Section: #{section.name}", data: data})
    end

    # Average Marks Data
    @avg_marks_data = []
    @klass.sections.each do |section|
      data = {}
      students = section.students.includes(:exam)
      [:english, :hindi, :mathematics, :science, :social].each do |subject_name|
        total_score = students.collect do |student|
          student.exam.send(subject_name)
        end.reduce(:+)
        data[subject_name.to_s.capitalize] = total_score / students.count
      end
      @avg_marks_data.push({name: "Section: #{section.name}", data: data})
    end

    # Grades Distribution Data
    sections = @klass.sections.includes(students: [:exam])
    students = sections.collect {|section| section.students}.flatten
    marks = students.collect(&:exam).collect{|ex| ex.total/5}
    data = {s: 0, a: 0, b: 0, c: 0, d:0, e: 0, f: 0}
    marks.each do |mark|
      if mark >= 90
        data[:s] += 1
      elsif mark >= 80
        data[:a] += 1
      elsif mark >= 70
        data[:b] += 1
      elsif mark >= 60
        data[:c] += 1
      elsif mark >= 50
        data[:d] += 1
      elsif mark >= 40
        data[:e] += 1
      else
        data[:f] += 1
      end
    end
    @grades_distribution_data = {}
    data.each do |key, val|
      @grades_distribution_data["Grade #{key.to_s.upcase}"] = val
    end
  end
end
