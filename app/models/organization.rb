class Organization < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  def no_users
    users.count
  end

  def fridge_amount
    Inventory.where(organization_id: id).sum(:amount)
  end

  def user_amount(user)
    user.total_for_organization(self)
  end
end
