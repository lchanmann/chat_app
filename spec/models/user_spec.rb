require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(2) }

  describe 'human scope' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:bot) { FactoryBot.create(:user, is_bot: true) }

    subject { described_class.human }

    it "should include user" do
      is_expected.to include(user)
    end

    it "should not include bot" do
      is_expected.not_to include(bot)
    end
  end
end
