class User < ApplicationRecord
  has_many :messages

  validates :name, presence: true, length: { minimum: 2 }
  validates :name, uniqueness: true

  scope :human, -> { where(is_bot: false) }

  def to_bot
    name.constantize.default rescue nil if is_bot
  end
end
