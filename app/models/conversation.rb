class Conversation < ApplicationRecord
  belongs_to :originator, class_name: "User"
  belongs_to :target, class_name: "User"
  has_many :messages, as: :dialogue

  validates :target_id, uniqueness: { scope: :originator_id }

  scope :of, -> (user) do
    where(originator: user).or(
      where(target: user)
    )
  end

  def other_party(user)
    if user.id == originator_id || user.id == target_id
      user.id == originator_id ? target : originator
    end
  end

  def to_s
    "Conversation-#{id}"
  end
end
