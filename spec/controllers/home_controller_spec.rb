require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let!(:chatroom) { FactoryBot.create(:chatroom) }

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

end
