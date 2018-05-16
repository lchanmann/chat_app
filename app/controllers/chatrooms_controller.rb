class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    cookies.encrypted[:username] ||= @chatroom.join!
  end
end
