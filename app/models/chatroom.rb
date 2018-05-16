class Chatroom < ApplicationRecord
  has_many :messages
  validates :title, presence: true

  def join!
    increment!(:peeps_count)
    "User#{peeps_count}"
  end
end
