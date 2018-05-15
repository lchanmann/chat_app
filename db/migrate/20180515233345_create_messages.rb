class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :sent_by
      t.string :content
      t.references :chatroom, foreign_key: true

      t.timestamps
    end
  end
end
