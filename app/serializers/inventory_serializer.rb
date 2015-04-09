class InventorySerializer < ActiveModel::Serializer
  attributes :amount
  has_one :beer
end
