require 'rails_helper'

RSpec.describe ChatChannel, type: :channel do
  let(:username) { 'test' }

  let!(:chatroom) { FactoryBot.create(:chatroom) }

  before do
    stub_connection username: username
    subscribe room_id: chatroom.id
  end

  it "should stream for chatroom" do
    expect(streams).to include(
      ChatChannel.broadcasting_for([ChatChannel.channel_name, chatroom])
    )
  end

  describe '#send_message' do
    let(:content) { 'content' }
    let(:user_message) { chatroom.messages.find_by(sent_by: username) }
    let(:bob_bot_message) { chatroom.messages.find_by(sent_by: BobBot.name) }

    it "should create user message" do
      perform :send_message, message: { content: content }

      expect(user_message).not_to be_nil
      expect(user_message.content).to eq(content)
      expect(user_message.dialogue).to eq(chatroom)
    end

    it "should create bob_bot response" do
      perform :send_message, message: { content: content }

      expect(bob_bot_message).not_to be_nil
      expect(user_message.dialogue).to eq(chatroom)
    end
  end
end
