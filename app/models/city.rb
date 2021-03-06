class City < ApplicationRecord
  validates :name, :code, :country, :lon, :lat, presence: true
  validates :code, length: { is: 6 }, numericality: { only_integer: true }
  validates :lon, :lat, numericality: true
  validates :country, length: { is: 2 }
  before_create :add_display

  def add_display
    self.display = false
  end
end
