class AttendanceRegistriesController < ApplicationController
  before_action :fetch_section

  def new
  end

private
  def fetch_section
    @klass = Klass.find(params[:klass_id])
    @section = @klass.sections.find(params[:section_id])
  end
end
