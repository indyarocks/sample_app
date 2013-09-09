# encoding: utf-8
#
# Author: Chandan
# Date: 09/09/2013
#
namespace :db do
  desc "Populate Users table with sample data"
  # populate_users task loads the environments, resets the db and populate users.
  task populate_users: [:environment, :reset] do
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
      password = "foobar"
      User.create!(
          name: name,
          email: email,
          password: password,
          password_confirmation: password
      )
    end

    puts "\n\nPlease run 'rake test:prepare' to setup test db.\n\n"
  end
end