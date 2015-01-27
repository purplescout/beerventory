class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  validates :user, :organization, presence: true
  validates :organization, uniqueness: { scope: :user }
end
