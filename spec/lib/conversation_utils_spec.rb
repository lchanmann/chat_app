require 'rails_helper'
require 'conversation_utils'

RSpec.describe ConversationUtils do

  describe '.conversation_between' do
    let(:user) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }

    subject { described_class.conversation_between(user, user2) }

    context 'when no existing conversation' do
      it "should create new conversation" do
        expect {
          subject
        }.to change(Conversation, :count).by(1)
      end
    end

    context 'when user is originator' do
      let!(:conversation) { FactoryBot.create(:conversation, originator: user, target: user2) }

      it "should get existing conversation" do
        is_expected.to eq(conversation)
      end
    end

    context 'when user is target user' do
      let!(:conversation) { FactoryBot.create(:conversation, originator: user2, target: user) }

      it "should get existing conversation" do
        is_expected.to eq(conversation)
      end
    end
  end

end
