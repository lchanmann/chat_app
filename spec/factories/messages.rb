FactoryBot.define do
  factory :message do
    association :dialogue, factory: :chatroom
    sent_by 'test'
    content 'message content'
  end
end
