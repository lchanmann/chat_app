class Message < ApplicationRecord
  belongs_to :chatroom

  after_create_commit :broadcast_message

  def create_bot_response(bot)
    response_params = { sent_by: bot.class.name, content: bot.respond(content) }
    chatroom.messages.create(response_params)
  end

  private
    def broadcast_message
      ChatChannel.broadcast_to(chatroom, self)
    end
end
