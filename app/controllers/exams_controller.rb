require 'rubygems'
require 'spreadsheet'

class ExamsController < ApplicationController
  def new
    @exam = Exam.new
  end

  def create
    begin
      file = params[:exam][:file]
      spreadsheet = Spreadsheet.open(file.tempfile)
      book = spreadsheet.worksheets.first
      rows = book.rows
      klass_name, section_name = rows[2].to_a
      klass = Klass.find_by(name: klass_name)
      section = klass.sections.find_by(name: section_name)
      (5...rows.count).each do |i|
        data = rows[i].to_a
        student = section.students.find_by(roll_number: data[0].to_i)
        exam = student.exam || student.create_exam
        exam.english     = data[2].to_i
        exam.hindi       = data[3].to_i
        exam.mathematics = data[4].to_i
        exam.science     = data[5].to_i
        exam.social      = data[6].to_i
        exam.save!
      end
      flash[:success] = "Marks updated successfully"
    rescue
      flash[:danger] = "Please check the formatting of the excel sheet"
    ensure
      redirect_to root_path
    end
  end
end
