class FixRefChatroomInMessages < ActiveRecord::Migration[5.2]
  def change
    remove_index :messages, :chatroom_id
    remove_foreign_key :messages, :chatrooms
    rename_column :messages, :chatroom_id, :dialogue_id

    add_column :messages, :dialogue_type, :string
    add_index :messages, [:dialogue_id, :dialogue_type]

    reversible do |dir|
      dir.up do
        Message.update_all dialogue_type: 'Chatroom'
      end
    end
  end
end
