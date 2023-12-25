class PlaceImage < ApplicationRecord
  belongs_to :place

  validates :image_url, presence: true
end