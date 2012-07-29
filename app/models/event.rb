class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid
  include Models::Plugins::Author
  include Models::Plugins::Slug

  before_save       :create_author, :create_slug
  after_validation  :geocode

  geocoded_by :location
  belongs_to  :user
  embeds_one  :meta

  field :title,       type: String
  field :slug,        type: String
  field :author,      type: String
  field :content,     type: String
  field :published,   type: Boolean, default: false
  field :location,    type: String
  field :coordinates, type: Array

  accepts_nested_attributes_for :meta

  attr_accessible :title, :slug, :author, :content, :published, :location, :meta_attributes

  validates :slug, alpha_dash: true, uniqueness: { case_sensitive: false }
end