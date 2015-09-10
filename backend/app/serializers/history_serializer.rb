class HistorySerializer < ActiveModel::Serializer
  attributes :in, :out
  has_one :beer
end
