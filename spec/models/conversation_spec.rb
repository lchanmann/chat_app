require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it { is_expected.to belong_to(:originator).class_name('User') }
  it { is_expected.to belong_to(:target).class_name('User') }
  it { is_expected.to have_many(:messages) }

  describe 'of scope' do
    let(:user) { FactoryBot.create(:user) }

    let!(:conversation_originated) { FactoryBot.create(:conversation, originator: user) }
    let!(:conversation_targeted) { FactoryBot.create(:conversation, target: user) }

    subject { described_class.of(user) }

    it "should include conversation originated by user" do
      is_expected.to include(conversation_originated)
    end

    it "should include conversation targeted to user" do
      is_expected.to include(conversation_targeted)
    end
  end

  describe '#other_party' do
    let(:user) { FactoryBot.create(:user) }

    subject { conversation.other_party(user) }

    context 'when user is originator' do
      let(:conversation) { FactoryBot.create(:conversation, originator: user) }

      it "should be target user" do
        is_expected.to eq(conversation.target)
      end
    end

    context 'when user is target user' do
      let(:conversation) { FactoryBot.create(:conversation, target: user) }

      it "should be originator" do
        is_expected.to eq(conversation.originator)
      end
    end

    context 'when user is not in conversation' do
      let(:conversation) { FactoryBot.create(:conversation) }

      it { is_expected.to be_nil }
    end
  end
end
