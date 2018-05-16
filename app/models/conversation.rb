class Conversation < ApplicationRecord
  belongs_to :originator, class_name: "User"
  belongs_to :target, class_name: "User"
  has_many :messages, as: :dialogue

  scope :of, -> (user) do
    where(originator: user).or(
      where(target: user)
    )
  end
end
