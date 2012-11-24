# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user.name
user2 = User.create! :name => 'Second User', :email => 'user2@example.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user2.name
user.add_role :admin

# Demo data
if Rails.env == 'development'
  recipients = [
    {name: 'Jack Jackson', email: 'jack.jackson@example.com'},
    {name: 'Sue Suzanne', email: 'sue.suzanne@example.com'},
    {name: 'Zim McCracken', email: 'zim.mc-cracken@example.com'},
    {name: 'Ginger Snap', email: 'ginger.snap@example.com'},
    {name: 'Sally Joe', email: 'sally.joe@example.com'},
    {name: 'Paul Stan', email: 'paul.stan@example.com'},
    {name: 'Gino Smith', email: 'gino.smith@example.com'},
    {name: 'Abe Lincoln', email: 'abe.lincoln@example.com'},
    {name: 'Smither Smithers', email: 'smithers@example.com'},
    {name: 'Paul Ryan', email: 'paul@example.com'},
    {name: 'Garfield Cat', email: 'garfield.cat@example.com'},
    {name: 'Peter Mary', email: 'peter.mary@example.com'}
  ]
  recipients.each { |recipient| Email.create! name: recipient[:name], email: recipient[:email] }

  applicants = [
    {name: 'Paul Rand', email: 'paul.rand@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Suzy Toe', email: 'suzy.toe@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Janice Joplin', email: 'janice.joplin@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Sting', email: 'sting@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Madonna', email: 'madonna@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Meatloaf', email: 'meatloaf@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Sally Joe', email: 'sally.joe@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Paul Stan', email: 'paul.stan@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Gino Smith', email: 'gino.smith@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Abe Lincoln', email: 'abe.lincoln@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Smither Smithers', email: 'smithers@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Paul Ryan', email: 'paul@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Jack Jackson', email: 'jack.jackson@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Sue Suzanne', email: 'sue.suzanne@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Zim McCracken', email: 'zim.mc-cracken@example.com', pitch: 'Lorem ipsum dolor ipsum.'},
    {name: 'Ginger Snap', email: 'ginger.snap@example.com', pitch: 'Lorem ipsum dolor ipsum.'}
  ]
  applicants.each { |applicant| Applicant.create!(name: applicant[:name], email: applicant[:email], pitch: applicant[:pitch]) }
end
