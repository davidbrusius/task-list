FactoryGirl.define do
  factory :favorite_list do
    user { create(:user) }
    list { create(:list, user: user, public_access: true) }
  end
end
