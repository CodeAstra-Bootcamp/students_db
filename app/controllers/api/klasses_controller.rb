module Api
  class KlassesController < ApplicationController
    def index
      @klasses = Klass.all
    end

    def show
      @klass = Klass.find(params[:id])
    end

    def create
      @klass = Klass.new
      @klass.name = params[:name]
      if @klass.save
        head :created, location: api_klass_url(@klass)
      else
        head :bad_request
      end
    end
  end
end
