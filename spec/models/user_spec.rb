require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(2) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to have_many(:messages) }

  describe 'human scope' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:bot) { FactoryBot.create(:user, :bot) }

    subject { described_class.human }

    it "should include user" do
      is_expected.to include(user)
    end

    it "should not include bot" do
      is_expected.not_to include(bot)
    end
  end

  describe '.to_bot' do
    let(:user) { FactoryBot.create(:user) }
    let(:bob) { FactoryBot.create(:user, :bot, name: BobBot.name) }
    let(:unknown_bot) { FactoryBot.create(:user, :bot, name: 'Unknown') }

    context 'when user is bob bot' do
      it { expect(bob.to_bot).to be_a(BobBot) }
    end

    context 'when user is not a bot' do
      it "should return nil" do
        expect(user.to_bot).to be_nil
      end
    end

    context 'when user is an unknown bot' do
      it "should return nil" do
        expect(unknown_bot.to_bot).to be_nil
      end
    end
  end
end
