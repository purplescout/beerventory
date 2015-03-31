class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :api_token

  def include_api_token?
    current_user == object
  end
end
