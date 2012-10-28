class Metum
  include Mongoid::Document

  field :title,       type: String
  field :keywords,    type: String
  field :description, type: String
end