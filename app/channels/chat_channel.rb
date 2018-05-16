class ChatChannel < ApplicationCable::Channel
  def subscribed
    @chatroom = Chatroom.find(params[:room_id])
    stream_for @chatroom
  end

  def send_message(data)
    message_params = { sent_by: username }.merge(data['message'])
    @chatroom.messages.create(message_params)
  end
end
