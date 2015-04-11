class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :volume
end
