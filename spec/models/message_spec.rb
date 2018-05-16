require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:chatroom) { FactoryBot.create(:chatroom) }

  it { is_expected.to belong_to(:chatroom) }

  describe '#create_bot_response' do
    let!(:message) { FactoryBot.create(:message, chatroom: chatroom) }

    let(:bot) { BobBot.default }

    subject { message.create_bot_response(bot) }

    it "should create response message in chatroom" do
      expect {
        subject
      }.to change(chatroom.messages, :count).by(1)
    end

    describe 'bot message' do
      it { is_expected.to have_attributes(sent_by: bot.class.name) }
    end
  end

  describe '#broadcast_message' do
    let(:message) { FactoryBot.build(:message, chatroom: chatroom) }

    it "should broadcast message to chatroom" do
      expect(ChatChannel).to receive(:broadcast_to).with(chatroom, message)
      message.save
    end
  end
end
