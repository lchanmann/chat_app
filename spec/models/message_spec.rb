require 'rails_helper'

RSpec.describe Message, type: :model do
  it { is_expected.to belong_to(:chatroom) }

  describe '#broadcast_message' do
    let(:chatroom) { FactoryBot.create(:chatroom) }
    let(:message) { FactoryBot.build(:message, chatroom: chatroom) }

    it "should broadcast message to chatroom" do
      expect(ChatChannel).to receive(:broadcast_to).with(chatroom, message)
      message.save
    end
  end
end
