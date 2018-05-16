require 'rails_helper'

RSpec.describe ChatChannel, type: :channel do
  let(:username) { 'test' }

  let!(:chatroom) { FactoryBot.create(:chatroom) }

  before do
    stub_connection username: username
    subscribe room_id: chatroom.id
  end

  it "should stream for chatroom" do
    expect(streams).to include(
      ChatChannel.broadcasting_for([ChatChannel.channel_name, chatroom])
    )
  end

  describe '#send_message' do
    let(:content) { 'content' }

    it "should create new message" do
      expect {
        perform :send_message, message: { content: content }
      }.to change(Message, :count).by(1)
    end

    describe 'created message' do
      subject { Message.last }

      before do
        perform :send_message, message: { content: content }
      end

      it { is_expected.to have_attributes(sent_by: username) }
      it { is_expected.to have_attributes(content: content) }
      it { is_expected.to have_attributes(chatroom: chatroom) }
    end
  end
end
