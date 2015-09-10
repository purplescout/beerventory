class Inventory < ActiveRecord::Base
  belongs_to :organization
  belongs_to :beer

  validates_presence_of :organization, :beer, :amount
end
