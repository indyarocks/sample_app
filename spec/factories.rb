FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "Chandan #{n}"}
    sequence(:email) {|n| "chandan.jhun#{n}@gmail.com"}
    password "foobar"
    password_confirmation "foobar"
  end
end