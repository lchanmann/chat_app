class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  validates :name, uniqueness: true

  scope :human, -> { where(is_bot: false) }
end
