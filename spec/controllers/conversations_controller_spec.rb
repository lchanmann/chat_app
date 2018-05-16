require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other) { FactoryBot.create(:user) }
  let(:another) { FactoryBot.create(:user) }

  let!(:conversation) { FactoryBot.create(:conversation, originator: user, target: other) }

  before do
    controller.instance_variable_set(:@current_user, user)
  end

  it { is_expected.to use_before_action(:enforce_authentication) }

  describe "GET #show" do
    it "assigns @conversation" do
      get :show, params: { id: conversation.id }
      expect(assigns(:conversation)).to eq(conversation)
    end

    it "assigns @other" do
      get :show, params: { id: conversation.id }
      expect(assigns(:other)).to eq(other)
    end

    it "renders show template" do
      get :show, params: { id: conversation.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns @users" do
      get :new
      expect(assigns(:users)).to eq([other])
    end

    it "renders new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #create" do
    it "creates new conversation with another user" do
      expect {
        post :create, params: { other: another.id }
      }.to change(Conversation, :count).by(1)
    end

    context 'when conversation exists' do
      it "should not create new conversation" do
        expect {
          post :create, params: { other: other.id }
        }.not_to change(Conversation, :count)
      end
    end

    it "redirect to the conversation" do
      post :create, params: { other: other.id }
      expect(response).to redirect_to(conversation)
    end
  end

end
