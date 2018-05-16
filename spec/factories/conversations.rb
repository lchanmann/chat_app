FactoryBot.define do
  factory :conversation do
    association :originator, factory: :user
    association :target, factory: :user
  end
end
