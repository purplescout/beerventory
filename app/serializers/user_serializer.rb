class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :api_token

  def include_api_token?
    current_user == object
  end
end
