require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:chatroom) { FactoryBot.create(:chatroom) }
  let(:conversation) { FactoryBot.create(:conversation) }

  it { is_expected.to belong_to(:dialogue) }
  it { is_expected.to belong_to(:user) }

  describe '#create_bot_response' do
    let(:bot) { BobBot.default }

    subject { message.create_bot_response(bot) }

    context 'on chatroom message' do
      let!(:message) { FactoryBot.create(:message, dialogue: chatroom) }

      it "should create message in the chatroom" do
        expect {
          subject
        }.to change(chatroom.messages, :count).by(1)
      end
    end

    context 'on private message' do
      let!(:message) { FactoryBot.create(:message, dialogue: conversation) }

      it "should create message in the conversation" do
        expect {
          subject
        }.to change(conversation.messages, :count).by(1)
      end
    end

    describe 'message' do
      let(:message) { FactoryBot.create(:message) }
      it { is_expected.to have_attributes(sent_by: bot.class.name) }
    end
  end

  describe '#broadcast_message' do
    let(:message) { FactoryBot.build(:message, dialogue: chatroom) }
    let(:message2) { FactoryBot.build(:message, dialogue: conversation) }

    it "should broadcast message to chatroom" do
      expect(ChatChannel).to receive(:broadcast_to).with(chatroom, message)
      message.save
    end

    it "should broadcast message to conversation" do
      expect(ChatChannel).to receive(:broadcast_to).with(conversation, message2)
      message2.save
    end
  end
end
