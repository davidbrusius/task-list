FactoryGirl.define do
  factory :list do
    user { create(:user) }
    subject Faker::Lorem.word
    public_access false
  end
end
