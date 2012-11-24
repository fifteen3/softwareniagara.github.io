class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Models::Plugins::Author
  include Models::Plugins::Slug

  before_validation :create_author, :create_slug

  belongs_to :user
  embeds_one :meta

  field :title,     type: String
  field :slug,      type: String
  field :author,    type: String
  field :content,   type: String
  field :published, type: Boolean, default: false

  accepts_nested_attributes_for :meta

  attr_accessible :title, :slug, :meta, :content, :published, :meta_attributes

  validates :slug, alpha_dash: true, uniqueness: { case_sensitive: false }
end