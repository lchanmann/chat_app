require 'rails_helper'

RSpec.describe ApplicationController do

  describe '#authenticate' do
    let(:user) { FactoryBot.create(:user) }

    before do
      session[:current_user_id] = user.id
      controller.send(:authenticate)
    end

    context 'when current_user_id session is valid' do
      it "should assign current_user" do
        expect(assigns(:current_user)).to eq(user)
      end
    end

    context 'when current_user_id session is not valid' do
      let(:user) { double(id: 1) }

      it "should not assign current_user" do
        expect(assigns(:current_user)).to be_nil
      end
    end

    context 'when current_user_id session is not present' do
      let(:user) { double(id: nil) }

      it "should not assign current_user" do
        expect(assigns(:current_user)).to be_nil
      end
    end
  end

  describe '#enforce_authentication' do
    context 'when current_user is not present' do
      it "should redirect_to root" do
        expect(controller).to receive(:redirect_to) do |url, opts|
          expect(url).to eq(root_url)
        end
        controller.send(:enforce_authentication)
      end
    end
  end

end
