class ApplicationController < ActionController::Base
  before_action :authenticate

  private
    def authenticate
      if authenticated_user = User.human.find_by(id: session[:current_user_id])
        cookies.encrypted[:username] = authenticated_user.name
        @current_user = authenticated_user
      end
    end

    def enforce_authentication
      @current_user || redirect_to(root_url)
    end
end
