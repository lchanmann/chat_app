FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    is_bot false
  end

  trait :bot do
    is_bot true
  end
end
