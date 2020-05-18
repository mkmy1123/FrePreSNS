class CreateExpressions < ActiveRecord::Migration[5.2]
  def change
    create_table :expressions do |t|
      t.integer :argumnet_id, null: false
      t.integer :user_id, null: false
      t.boolean :is_argument
      t.string :statement, null: false
      t.string :detial

      t.timestamps
    end
  end
end
