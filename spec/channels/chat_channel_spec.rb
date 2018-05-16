require 'rails_helper'

RSpec.describe ChatChannel, type: :channel do
  let(:user) { FactoryBot.create(:user) }
  let(:username) { user.name }
  let(:bob) { FactoryBot.create(:user, :bot, name: BobBot.name) }

  before { stub_connection username: username, current_user: user }

  describe '#subscribed' do
    %w(chatroom conversation).each do |type|
      context "to #{type}" do
        let(:dialogue) { FactoryBot.create(type) }

        before { subscribe room: "#{type.capitalize}-#{dialogue.id}" }

        it "should stream from #{type}" do
          expect(streams).to include(
            ChatChannel.broadcasting_for([ChatChannel.channel_name, dialogue])
          )
        end
      end
    end
  end

  describe '#send_message' do
    let(:chatroom) { FactoryBot.create(:chatroom) }
    let(:content) { 'content' }
    let(:user_message) { chatroom.messages.find_by(sent_by: username) }
    let(:bob_bot_message) { chatroom.messages.find_by(sent_by: BobBot.name) }

    before { subscribe room: "Chatroom-#{chatroom.id}" }

    it "should store user message" do
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

  describe '#send_private_message' do
    let(:conversation) { FactoryBot.create(:conversation, originator: user, target: bob) }
    let(:content) { 'content' }
    let(:user_message) { conversation.messages.find_by(sent_by: username) }
    let(:bob_bot_message) { conversation.messages.find_by(sent_by: BobBot.name) }

    before { subscribe room: "Conversation-#{conversation.id}" }

    it "should store user message" do
      perform :send_private_message, message: { content: content }

      expect(user_message).not_to be_nil
      expect(user_message.content).to eq(content)
      expect(user_message.dialogue).to eq(conversation)
    end

    context 'when other party is bob bot' do
      it "should create bob_bot response" do
        perform :send_message, message: { content: content }

        expect(bob_bot_message).not_to be_nil
        expect(user_message.dialogue).to eq(conversation)
      end
    end

    context 'when other party is a user' do
      let(:conversation) { FactoryBot.create(:conversation, originator: user) }

      it "should not create bot response" do
        perform :send_private_message, message: { content: content }

        expect(bob_bot_message).to be_nil
      end
    end
  end
end
