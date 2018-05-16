require 'rails_helper'

RSpec.describe ChatroomsController, type: :controller do
  let!(:chatroom) { FactoryBot.create(:chatroom) }
  let!(:message) { FactoryBot.create(:message, chatroom: chatroom) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to be_successful
    end

    it "assigns @chatrooms" do
      get :index
      expect(assigns(:chatrooms)).to eq([chatroom])
    end

    it "renders index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

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
  end

end
