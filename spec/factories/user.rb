FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
    password '123456'
    password_confirmation '123456'
  end
end
