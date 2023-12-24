class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  def index
    client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
    places = client.spots(35.681318174002534, 139.76713519281384,detail: true,name: 'サウナ',language: 'ja')

    places.each do |place|
      puts "Place Name: #{place.name}"
      puts "Place Address: #{place.formatted_address}"
      puts "Phone Number: #{place.formatted_phone_number}"
      puts "Rating: #{place.rating}"
      puts "Opening Hours: #{place.opening_hours}"
      puts "Website: #{place.website}"

      # データベースに保存
      existing_place = Place.find_by(latitude: place.lat, longitude: place.lng)

      if existing_place.nil?
        new_place = Place.create(
          latitude: place.lat,
          longitude: place.lng,
          name: place.name,
          address: place.formatted_address,
          rating_avg: place.rating,
          phone_number: place.formatted_phone_number,
          opening_hours: place.opening_hours,
          website: place.website
          # 他の必要な属性もここに追加
        )

        if new_place.errors.any?
          Rails.logger.error("Error saving place: #{new_place.errors.full_messages.join(', ')}")
        else
          Rails.logger.info("Place saved successfully!")
        end
      else
        Rails.logger.info("Place already exists. Skipped saving.")
      end

      @places = Place.all
    end
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