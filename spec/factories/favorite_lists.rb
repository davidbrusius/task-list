FactoryGirl.define do
  factory :favorite_list do
    user
    list { create(:public_list, user: user) }
  end
end
