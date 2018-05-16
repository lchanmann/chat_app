require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  let(:username) { 'test' }

  it "should identify connection using cookies" do
    connect "/cable", cookies: { username: username }
    expect(connection.username).to eq username
  end
end
