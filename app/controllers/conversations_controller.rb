require 'conversation_utils'

class ConversationsController < ApplicationController
  before_action :enforce_authentication

  def show
    @conversation = Conversation.find(params[:id])
    @other = @conversation.other_party(@current_user)
  end

  def new
    @users = User.where.not(id: @current_user.id)
  end

  def create
    other = User.find(params[:other])
    conversation = ConversationUtils.conversation_between(@current_user, other)
    redirect_to conversation
  end
end
