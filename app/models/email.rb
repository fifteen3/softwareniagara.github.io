class Email
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,            type: String
  field :email,           type: String
  field :website,         type: String
  field :twitter_handle,  type: String
  field :interests,       type: String
  field :location,        type: String
  field :format,          type: String, default: 'html'
  field :subscribed,      type: String, default: true

  attr_accessible :name, :email, :website, :twitter_handle, :interests, :location, :format, :subscribed
end