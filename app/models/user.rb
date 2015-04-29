class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :memberships
  has_many :organizations, through: :memberships

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, presence: true, uniqueness: true

  validates :api_token, presence: true, uniqueness: true

  before_validation do
    self.api_token = SecureRandom.base64(48) if password.present?
  end

  def total_for_organization(organization)
    all_in = History.where(user_id: id, organization_id: organization.id).sum(:in)
    all_out = History.where(user_id: id, organization_id: organization.id).sum(:out)
    all_in - all_out
  end
end
