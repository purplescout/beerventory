class Organization < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
end
