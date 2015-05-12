class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :no_users, :fridge_amount, :user_amount

  def user_amount
    object.user_amount(scope)
  end

  def include_no_users?
    @options[:status_values].present?
  end

  def include_fridge_amount?
    @options[:status_values].present?
  end

  def include_user_amount?
    @options[:status_values].present?
  end
end
