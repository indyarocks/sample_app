# encoding: utf-8
#
# Author: Chandan
# Date: 09/09/2013
#
namespace :db do
  desc "Populate Users table with sample data"
  # populate_users task loads the environments, resets the db and populate users.
  task populate_users: [:environment] do
    puts "\n\nPlease run 'rake db:reset' before this rake task.\n\n"
    User.create!(
        name: "Chandan Kumar",
        email: "chandan.jhun@gmail.com",
        password: "foobar",
        password_confirmation: "foobar",
        admin: true
    )

    99.times do |n|
      name = Faker::Name.name
      email = Faker::Internet.email
      password = rand(36**10).to_s(36)  # Generate random password for each user :P
      User.create!(
          name: name,
          email: email,
          password: password,
          password_confirmation: password
      )
    end

    users = User.all(limit: 6)

    50.times do
      content = Faker::Lorem.sentence(5)
      users.each {|user| user.microposts.create!(content: content)}
    end

    puts "\n\nPlease run 'rake test:prepare' to setup test db.\n\n"
  end
end