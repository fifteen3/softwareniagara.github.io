class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Models::Plugins::Slug

  before_save   :create_slug

  embeds_one    :meta
  embeds_one    :venue
  embeds_one    :organizer

  field :import_id,       type: String
  field :import_source,   type: String, default: 'softwareniagara'
  field :title,           type: String
  field :description,     type: String
  field :tags,            type: Array
  field :categories,      type: Array
  field :status,          type: String
  field :capacity,        type: Integer
  field :sold,            type: Integer
  field :time,            type: Hash
  field :slug,            type: String

  validates :slug, alpha_dash: true, uniqueness: {case_sensitive: false}
end