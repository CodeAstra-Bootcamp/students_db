# == Schema Information
#
# Table name: exams
#
#  id          :integer          not null, primary key
#  student_id  :integer
#  english     :integer
#  hindi       :integer
#  mathematics :integer
#  science     :integer
#  social      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spreadsheet_parser'

class ExamsController < ApplicationController
  def index
    student = Student.find(params[:student_id])
    @exam = student.exam
  end

  def new
    @exam = Exam.new
  end

  def create
    begin
      file = params[:exam][:file]
      rows = SpreadsheetParser.new(file.tempfile)
      Exam.upload(rows)
      flash[:success] = "Marks updated successfully"
    rescue
      flash[:danger] = "Please check the formatting of the excel sheet"
    ensure
      redirect_to root_path
    end
  end
end
