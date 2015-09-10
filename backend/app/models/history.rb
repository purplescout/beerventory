class History < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  belongs_to :beer

  validates_presence_of :user, :organization, :beer, :in, :out
end
