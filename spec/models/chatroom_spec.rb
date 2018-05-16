require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  it { is_expected.to have_many(:messages) }
  it { is_expected.to validate_presence_of(:title) }
end
