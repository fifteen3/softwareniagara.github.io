class Applicant
  include Mongoid::Document
  include Mongoid::Timestamps

  paginates_per 10

  field :name,            type: String
  field :company,         type: String
  field :email,           type: String
  field :website,         type: String
  field :twitter_handle,  type: String
  field :pitch,           type: String
  field :location,        type: String
  field :type,            type: String, default: 'Demo Camp'

  attr_accessible :name, :company, :email, :website, :twitter_handle, :pitch, :location, :type

  validates :name, presence: true
  validates :email, presence: true, email: true
  validates :twitter_handle, allow_blank: true, format: { with: /^([a-zA-Z](_?[a-zA-Z0-9]+)*_?|_([a-zA-Z0-9]+_?)*)$/i, message: 'not a valid twitter handle' }
  validates :website, allow_blank: true, url: true
  validates :pitch, presence: true
end