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
    @data = []
    @klass.sections.each do |section|
      data = {}
      students_count = section.students.count
      attendance_registries = section.attendance_registries.includes(:absentees)
      attendance_registries.each do |ar|
        data[ar.date] = 100*(students_count - ar.absentees.count)/students_count
      end
      @data.push({name: "Section: #{section.name}", data: data})
    end
  end
end
