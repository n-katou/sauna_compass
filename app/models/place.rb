class Place < ApplicationRecord
  geocoded_by :address
  after_validation :geocode

  validates :name, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

  # 他のバリデーションやリレーションなどを追加できます

  # データベースに保存される前に実行されるコールバック
  before_save :calculate_rating_avg

  private

  # rating_avg を計算するコールバック
  def calculate_rating_avg
    # rating_avg が未設定の場合、自動的に計算するロジックを追加
    self.rating_avg ||= calculate_average_rating
  end

  def calculate_average_rating
    # rating_avg を計算するロジックをここに追加
    # 例えば、関連するレビューから平均を計算するなど
  end

end