class CreateChatrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chatrooms do |t|
      t.string :title, null: false
      t.bigint :peeps_count, default: 0

      t.timestamps
    end
  end
end
