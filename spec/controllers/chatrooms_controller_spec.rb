require 'rails_helper'

RSpec.describe ChatroomsController, type: :controller do
  let!(:chatroom) { FactoryBot.create(:chatroom) }
  let!(:message) { FactoryBot.create(:message, dialogue: chatroom) }

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: chatroom.id }
      expect(response).to be_successful
    end

    it "assigns @chatroom" do
      get :show, params: { id: chatroom.id }
      expect(assigns(:chatroom)).to eq(chatroom)
    end

    it "renders show template" do
      get :show, params: { id: chatroom.id }
      expect(response).to render_template(:show)
    end

    it "assigns username when not exists" do
      expect {
        get :show, params: { id: chatroom.id }
      }.to change { cookies.encrypted['username'] }
    end

    it "should not change username when already exists" do
      cookies.encrypted['username'] = 'test'
      expect {
        get :show, params: { id: chatroom.id }
      }.not_to change { cookies.encrypted['username'] }
    end
  end

end
