class Chatroom < ApplicationRecord
  has_many :messages, as: :dialogue
  validates :title, presence: true

  def join!
    increment!(:peeps_count)
    "User#{peeps_count}"
  end
end
