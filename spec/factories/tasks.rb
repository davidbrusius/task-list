FactoryGirl.define do
  factory :task do
    list
    description Faker::Lorem.word
  end
end
