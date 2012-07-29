class Applicant
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,            type: String
  field :company,         type: String
  field :email,           type: String
  field :website,         type: String
  field :twitter_handle,  type: String
  field :pitch,           type: String
  field :location,        type: String
  field :type,            type: String, default: 'Demo Camp'

  attr_accessible :name, :company, :email, :website, :twitter_handle, :pitch, :location, :type
end