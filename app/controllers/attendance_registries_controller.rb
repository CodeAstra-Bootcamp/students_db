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
  before_action :fetch_attendance_registry, only: [:new, :create, :update]
  skip_before_filter :verify_authenticity_token

  def new
    @students = @section.students
    @absent_student_ids = @attendance_registry.absentees.pluck(:student_id)
  end

  def create
    save_attendance_registry
  end

  def update
    save_attendance_registry
    render :create
  end

private
  def fetch_section
    @klass = Klass.find(params[:klass_id])
    @section = @klass.sections.find(params[:section_id])
  end

  def fetch_attendance_registry
    @attendance_registry = @section.attendance_registries.find_by(date: Date.today)
    @attendance_registry = @section.attendance_registries.new unless @attendance_registry
  end

  def save_attendance_registry
    @attendance_registry.date = Date.today
    @attendance_registry.absent_student_ids = params[:attendance_registry][:absent_student_ids].split(",").collect(&:to_i)
    @attendance_registry.save!
  end
end
