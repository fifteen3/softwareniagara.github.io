class Metum
  include Mongoid::Document

  embedded_in :post, :event

  field :title,       type: String
  field :keywords,    type: String
  field :description, type: String
end