require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  let(:user) { FactoryBot.create(:user) }
  let(:username) { user.name }

  it "should identify username from cookies" do
    connect "/cable", cookies: { username: username }
    expect(connection.username).to eq username
  end

  it "should identify current_user from cookies" do
    connect "/cable", cookies: { username: username }
    expect(connection.username).to eq username
  end
end
