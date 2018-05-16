class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.references :originator, foreign_key: { to_table: :users }
      t.references :target, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
