class CreateComponents < ActiveRecord::Migration[5.2]
  def change
    create_table :components do |t|
      t.integer :user_id, null: false
      t.integer :kind_of, null: false
      t.string :title, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
