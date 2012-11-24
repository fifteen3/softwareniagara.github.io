class Venue
  include Mongoid::Document

  embedded_in :event

  field :import_id,     type: String
  field :import_source, type: String
  field :name,          type: String
  field :address,       type: String
  field :city,          type: String
  field :region,        type: String
  field :country,       type: String
  field :postal_code,   type: String
  field :latitude,      type: String
  field :longitude,     type: String
end