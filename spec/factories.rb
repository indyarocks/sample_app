FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "Chandan #{n}"}
    sequence(:email) {|n| "chandan.jhun#{n}@gmail.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    sequence(:content) {|n| "Lorem ipsum #{n}"}
    user
  end
end