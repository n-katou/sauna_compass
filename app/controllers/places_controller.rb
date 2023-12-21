class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  def index
    @places = Place.all
  end

  def show
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      redirect_to places_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @place.update(place_params)
      redirect_to @place
    else
      render :edit
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to places_path, notice: 'Place was successfully destroyed.'
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :address, :rating_avg, :longitude, :latitude, :phone_number, :opening_hours, :website)
  end
end