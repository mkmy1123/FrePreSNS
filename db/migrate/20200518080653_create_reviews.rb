class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :expression_id, null: false
      t.integer :rate, null: false

      t.timestamps
    end
  end
end
