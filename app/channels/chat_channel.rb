class ChatChannel < ApplicationCable::Channel
  def subscribed
    klass, id = params[:room].split('-')
    @dialogue = klass.constantize.find(id)
    stream_for @dialogue
  end

  def send_message(data)
    message = save_message(data['message'])
    message.create_bot_response(BobBot.default) if message
  end

  def send_private_message(data)
    message = save_message(data['message'])
    bot = @dialogue.other_party(current_user).to_bot

    message.create_bot_response(bot) if message && bot
  end

  private
    def save_message(params)
      @dialogue.messages.create({
        sent_by: username,
        user: current_user
      }.merge(params))
    end
end
