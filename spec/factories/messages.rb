FactoryBot.define do
  factory :message do
    chatroom
    sent_by 'test'
    content 'message content'
  end
end
