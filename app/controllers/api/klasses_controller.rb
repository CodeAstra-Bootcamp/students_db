module Api
  class KlassesController < ApplicationController
    before_action :fetch_klass, only: [:show, :update]

    def index
      @klasses = Klass.all
    end

    def show
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

    def update
      @klass.name = params[:name]
      if @klass.save
        head :accepted, location: api_klass_url(@klass)
      else
        head :bad_request
      end
    end

  private
    def fetch_klass
      @klass = Klass.find(params[:id])
    end
  end
end
