class Message < ApplicationRecord
  belongs_to :dialogue, polymorphic: true

  after_create_commit :broadcast_message

  def create_bot_response(bot)
    response_params = { sent_by: bot.class.name, content: bot.respond(content) }
    dialogue.messages.create(response_params)
  end

  private
    def broadcast_message
      ChatChannel.broadcast_to(dialogue, self)
    end
end
