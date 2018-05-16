class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }

  scope :human, -> { where(is_bot: false) }
end
