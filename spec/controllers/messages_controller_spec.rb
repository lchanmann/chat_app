require 'rails_helper'

RSpec.describe MessagesController do
  describe 'GET #index' do
    it { is_expected.to use_before_action(:chatroom_messages) }
    it { is_expected.to use_before_action(:enforce_authentication) }
    it { is_expected.to use_before_action(:conversation_messages) }

    let(:message_json) { ActiveModelSerializers::SerializableResource.new(message) }

    context 'for chatroom' do
      let(:chatroom) { FactoryBot.create(:chatroom) }
      let!(:message) { FactoryBot.create(:message, dialogue: chatroom) }

      it "gets messages from chatroom" do
        get :index, params: { chatroom_id: chatroom.id }
        expect(assigns(:messages)).to eq([message])
      end

      it "renders json response" do
        get :index, params: { chatroom_id: chatroom.id }
        expect(response.body).to eq([message_json].to_json)
      end

      context 'when accessing non existent chatroom' do
        it {
          expect {
            get :index, params: { chatroom_id: 'not_exist' }
          }.to raise_error(ActiveRecord::RecordNotFound)
        }
      end
    end

    context 'for conversation' do
      let(:user) { FactoryBot.create(:user) }
      let(:conversation) { FactoryBot.create(:conversation, originator: user) }
      let!(:message) { FactoryBot.create(:message, dialogue: conversation, user: user) }

      let(:conversation2) { FactoryBot.create(:conversation, target: user) }
      let!(:message2) { FactoryBot.create(:message, dialogue: conversation2, user: user) }

      context 'when user is authenticated' do
        before { controller.instance_variable_set(:@current_user, user) }

        it "gets messages from user conversation" do
          get :index, params: { conversation_id: conversation.id }
          expect(assigns(:messages)).to eq([message])
        end

        it "renders json response" do
          get :index, params: { conversation_id: conversation.id }
          expect(response.body).to eq([message_json].to_json)
        end

        it "does not include message from other conversation" do
          get :index, params: { conversation_id: conversation.id }
          expect(assigns(:messages)).not_to include(message2)
        end

        context 'when accessing non existent conversation' do
          it {
            expect {
              get :index, params: { conversation_id: 'not_exist' }
            }.to raise_error(ActiveRecord::RecordNotFound)
          }
        end
      end

      context 'when user is not authenticated' do
        it {
          get :index, params: { conversation_id: conversation.id }
          expect(response).to redirect_to(root_url)
        }
      end
    end
  end

end
