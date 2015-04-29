class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :api_token
  has_many :organizations

  def include_api_token?
    current_user == object
  end

  def include_organizations?
    !@options[:skip_organizations]
  end
end
