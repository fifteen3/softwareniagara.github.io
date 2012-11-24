class Organizer
  include Mongoid::Document

  embedded_in :event

  field :import_id,     type: String
  field :import_source, type: String, default: 'softwareniagara'
  field :name,          type: String
  field :description,   type: String
  field :url,           type: String
end