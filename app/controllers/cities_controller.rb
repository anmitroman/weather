class CitiesController < ApplicationController
  #caches_page :show
  def index
    @city = City.all
  end
  def show
    @city = City.find(params[:id])
  end  
end
