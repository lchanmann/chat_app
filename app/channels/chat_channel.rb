class ChatChannel < ApplicationCable::Channel
  def subscribed
    klass, id = params[:room].split('-')
    @dialogue = klass.constantize.find(id)
    stream_for @dialogue
  end

  def send_message(data)
    message = @dialogue.messages.create(message_params.merge(data['message']))
    message.create_bot_response(BobBot.default) if message
  end

  def send_private_message(data)
    message = @dialogue.messages.create(message_params.merge(data['message']))
    bot = @dialogue.other_party(current_user).to_bot

    message.create_bot_response(bot) if message && bot
  end

  private
    def message_params
      { sent_by: username, user: current_user }
    end
end
