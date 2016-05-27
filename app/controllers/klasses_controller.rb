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
  end
end
