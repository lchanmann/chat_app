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
end
