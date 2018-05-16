class HomeController < ApplicationController
  def index
    @chatrooms = Chatroom.all
    @conversations = Conversation.of(@current_user) if @current_user
  end
end
