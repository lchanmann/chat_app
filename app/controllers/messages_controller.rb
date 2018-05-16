class MessagesController < ApplicationController
  before_action :chatroom_messages, on: :index, if: -> { params[:chatroom_id] }
  before_action :enforce_authentication, on: :index, if: -> { params[:conversation_id] }
  before_action :conversation_messages, on: :index, if: -> { params[:conversation_id] }

  def index
    render json: @messages
  end

  private
    def chatroom_messages
      @messages = Chatroom.find(params[:chatroom_id]).messages
    end

    def conversation_messages
      if params[:conversation_id]
        @messages = ConversationUtils.conversations_for(@current_user).
          find(params[:conversation_id]).messages
      end
    end
end
