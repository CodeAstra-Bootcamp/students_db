# == Schema Information
#
# Table name: attendance_registries
#
#  id         :integer          not null, primary key
#  date       :date
#  section_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AttendanceRegistriesController < ApplicationController
  before_action :fetch_section
  skip_before_filter :verify_authenticity_token

  def new
    @students = @section.students
    @new_attendance_registry = @section.attendance_registries.new
  end

  def create
    @attendance_registry = @section.attendance_registries.find_by(date: Date.today)
    @attendance_registry = @section.attendance_registries.new unless @attendance_registry
    @attendance_registry.date = Date.today
    @attendance_registry.absent_student_ids = params[:attendance_registry][:absent_student_ids].split(",").collect(&:to_i)
    @attendance_registry.save!
  end

private
  def fetch_section
    @klass = Klass.find(params[:klass_id])
    @section = @klass.sections.find(params[:section_id])
  end
end
