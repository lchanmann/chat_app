require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:bot) { FactoryBot.create(:user, :bot) }

  describe 'GET #new' do
    it "assigns @users to include user" do
      get :new
      expect(assigns(:users)).to include(user)
    end

    it "assigns @users to not include bot" do
      get :new
      expect(assigns(:users)).not_to include(bot)
    end
  end

  describe 'POST #create' do
    it "stores current user id" do
      post :create, params: { user_id: user.id }
      expect(session[:current_user_id]).to eq(user.id)
    end

    it "redirects to root url" do
      post :create, params: { user_id: user.id }
      expect(response).to redirect_to(root_url)
    end

    it "raises error login as bot" do
      expect {
        post :create, params: { user_id: bot.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'GET #destroy' do
    before do
      session[:current_user_id] = user.id
      cookies.encrypted[:username] = user.name
    end

    it "deletes current user id" do
      get :destroy
      expect(session[:current_user_id]).to be_nil
    end

    it "deletes username cookies" do
      get :destroy
      expect(cookies.encrypted[:username]).to be_nil
    end
  end

end
