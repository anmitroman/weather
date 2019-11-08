class CitiesController < ApplicationController
  def index
    @city = City.where(display: true)
  end

  def show
    @city = City.find(params[:id])
  end
end
