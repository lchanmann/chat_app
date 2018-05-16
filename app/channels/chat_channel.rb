require 'bob_bot'

class ChatChannel < ApplicationCable::Channel
  def subscribed
    @chatroom = Chatroom.find(params[:room_id])
    stream_for @chatroom
  end

  def send_message(data)
    message_params = { sent_by: username }.merge(data['message'])
    if message = @chatroom.messages.create(message_params)
      message.create_bot_response(BobBot.default)
    end
  end
end
