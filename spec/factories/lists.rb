FactoryGirl.define do
  factory :list do
    user
    subject Faker::Lorem.word
    public_access false

    factory :public_list do
      public_access true
    end
  end
end
