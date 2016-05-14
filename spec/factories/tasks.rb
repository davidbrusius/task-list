FactoryGirl.define do
  factory :task do
    list { create(:list) }
    description Faker::Lorem.word
  end
end
