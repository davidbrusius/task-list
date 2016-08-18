FactoryGirl.define do
  factory :task do
    list
    description Faker::Lorem.words(3).join(' ')

    factory :task_done do
      done true
    end
  end
end
