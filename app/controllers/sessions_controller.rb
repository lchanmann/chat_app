class SessionsController < ApplicationController
  def new
    @users = User.human
  end

  def create
    user = User.human.find(params[:user_id])
    session[:current_user_id] = user.id
    redirect_to(root_url)
  end

  def destroy
    session.delete(:current_user_id)
    cookies.delete(:username)
    redirect_to(root_url)
  end
end
