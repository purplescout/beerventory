class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :memberships
  has_many :organizations, through: :memberships

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, presence: true, uniqueness: true
end
