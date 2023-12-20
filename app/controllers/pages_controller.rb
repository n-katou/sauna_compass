class PagesController < ApplicationController
  def home
     @api_key = ENV['GOOGLE_MAP_API_KEY']
  end
end