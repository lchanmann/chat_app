require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  it { is_expected.to have_many(:messages) }
  it { is_expected.to validate_presence_of(:title) }

  subject { FactoryBot.create(:chatroom) }

  describe '#join!' do
    let(:chatroom) { FactoryBot.create(:chatroom) }

    it "should increase peeps_count" do
      expect {
        chatroom.join!
      }.to change(chatroom, :peeps_count).by(1)
    end

    it "should return sequenced username" do
      expect(chatroom.join!).to eq('User1')
      expect(chatroom.join!).to eq('User2')
      expect(chatroom.join!).to eq('User3')
    end
  end

  describe '#to_s' do
    it { expect(subject.to_s).to eq("Chatroom-#{subject.id}") }
  end
end
