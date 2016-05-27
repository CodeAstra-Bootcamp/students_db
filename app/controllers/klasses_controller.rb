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
      14.downto(0).each do |i|
        day = Date.today - i.days
        attendance_registry = section.attendance_registries.where(date: day).first
        next if attendance_registry.nil?

        absentees_count = attendance_registry.absentees.length
        present_count = section.students.length - absentees_count
        percentage_present = 100*present_count/section.students.length
        data[day] = percentage_present
      end
      @data.push({name: section.pretty_name, data: data})
    end
  end
end
