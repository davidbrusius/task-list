FactoryGirl.define do
  factory :list do
    subject Faker::Lorem.word
    public_access false
  end
end
