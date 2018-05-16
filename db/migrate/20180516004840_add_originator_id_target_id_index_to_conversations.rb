class AddOriginatorIdTargetIdIndexToConversations < ActiveRecord::Migration[5.2]
  def change
    add_index :conversations, [:originator_id, :target_id], unique: true
  end
end
