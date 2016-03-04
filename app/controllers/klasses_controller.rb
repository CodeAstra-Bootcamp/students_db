class KlassesController < ApplicationController
  def index
    @klasses = Klass.all
    @new_klass = Klass.new
  end

  def create
    @klass = Klass.new
    @klass.name = params[:klass][:name]
    @save_success = @klass.save
  end
end
