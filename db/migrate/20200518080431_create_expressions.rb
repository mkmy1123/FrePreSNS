class CreateExpressions < ActiveRecord::Migration[5.2]
  def change
    create_table :expressions do |t|
      t.integer :argument_id, null: false
      t.integer :user_id, null: false
      t.integer :style, default: 0
      t.string :statement, null: false
      t.string :detail

      t.timestamps
    end
  end
end
