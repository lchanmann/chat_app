class Message < ApplicationRecord
  belongs_to :chatroom

  after_create_commit :broadcast_message

  private
    def broadcast_message
      ChatChannel.broadcast_to(chatroom, self)
    end
end
