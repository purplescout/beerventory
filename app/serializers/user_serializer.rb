class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :api_token, :beer_amount
  has_many :organizations

  def beer_amount
    object.total_for_organization(@options[:include_amount_for_organization])
  end

  def include_beer_amount?
    @options[:include_amount_for_organization].present?
  end

  def include_api_token?
    current_user == object
  end

  def include_organizations?
    !@options[:skip_organizations]
  end
end
