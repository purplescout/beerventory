class Beer < ActiveRecord::Base
  validates :barcode, presence: true, uniqueness: true
  validates :name, presence: true
  validates :volume, presence: true, numericality: true
end
