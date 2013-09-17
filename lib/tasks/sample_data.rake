# encoding: utf-8
#
# Author: Chandan
# Date: 09/09/2013
#
namespace :db do
  desc "Populate Users table with sample data"
  # populate_users task loads the environments, resets the db and populate users.
  task populate_sample_data: [:environment] do
    puts "\n\nPlease run 'rake db:reset' before this rake task.\n\n"

    make_users
    make_microposts
    make_relationships

    puts "\n\nPlease run 'rake test:prepare' to setup test db.\n\n"
  end

  def make_users
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
  end

  def make_microposts
    users = User.all(limit: 6)

    50.times do
      content = Faker::Lorem.sentence(5)
      users.each {|user| user.microposts.create!(content: content)}
    end
  end

  def make_relationships
    users = User.all
    user = User.first
    followed_users = users[2..50]
    followers = users[3..40]
    followed_users.each {|followed| user.follow!(followed)}
    followers.each {|follower| follower.follow!(user)}
  end
end