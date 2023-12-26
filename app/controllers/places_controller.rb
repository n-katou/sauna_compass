class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  def index
  #   # Google Places APIを使用してサウナの情報を取得
  #   client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
  #   places = client.spots(35.6895,139.6917, detail: true, name: 'サウナ',radius: 50000, language: 'ja')

  #   # 各サウナの情報に対して処理を行う
  #   places.each do |place|
  #     puts "Place Name: #{place.name}"
  #     puts "Place Address: #{place.formatted_address}"
  #     puts "Phone Number: #{place.formatted_phone_number}"
  #     puts "Rating: #{place.rating}"

  #     opening_hours = place.opening_hours
  #     if opening_hours
  #       puts "Opening Hours: #{opening_hours['weekday_text'].join("\n")}"

  #       # データベースに保存
  #       existing_place = Place.find_by(latitude: place.lat, longitude: place.lng)

  #       if existing_place.nil?
  #         # 新しいサウナのレコードを作成
  #         new_place = Place.create(
  #           latitude: place.lat,
  #           longitude: place.lng,
  #           name: place.name,
  #           address: place.formatted_address,
  #           rating_avg: place.rating,
  #           phone_number: place.formatted_phone_number,
  #           opening_hours: opening_hours['weekday_text'].join("\n"),
  #           website: place.website
  #           # 他の必要な属性もここに追加
  #         )

  #         if new_place.errors.any?
  #           puts "Error saving place: #{new_place.errors.full_messages.join(', ')}"
  #         else
  #           puts "Place saved successfully!"

  #           place.photos.each do |photo|
  #             # photo_reference を使用して写真の URL を構築
  #             google_api_key = ENV['GOOGLE_API_KEY']
  #             image_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=#{photo.width}&maxheight=#{photo.height}&photoreference=#{photo.photo_reference}&key=#{google_api_key}"
  #             puts "Image URL: #{image_url}" # デバッグログの追加
  #             download_and_save_image(new_place, image_url) if image_url.present?

  #             # 最初の写真のみ保存するため、ループを抜ける
  #             break
  #           end
  #         end
  #       else
  #         puts "Place already exists. Skipped saving."
  #       end
  #     else
  #       puts "営業時間情報がありません"
  #     end

  #     puts "Website: #{place.website}"
  #     puts "------"
  #   end

    @places = Place.all
  end

  # 写真をダウンロードして保存するメソッド
  def download_and_save_image(place, image_url)
    # PlaceImage モデルに画像の URL を保存
    place_image = place.place_images.create(image_url: image_url)

    if place_image.errors.any?
      puts "Error saving image: #{place_image.errors.full_messages.join(', ')}"
    else
      puts "Image saved successfully!"
    end
  end


  def show
    begin
      opening_hours_hash = JSON.parse!(@place.opening_hours)

      # weekday_textを取得し、改行を挿入して表示
      @formatted_opening_hours = opening_hours_hash["weekday_text"].join("<br>")

      # その他の処理やレンダリングロジックはここに記述します
    rescue JSON::ParserError => e
      # JSONパースエラーが発生した場合の処理
      puts "JSONパースエラー: #{e.message}"
    end
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