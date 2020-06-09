class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :argument_id
      t.integer :expression_id
      t.integer :event_id
      t.string :action, default: '', null: false
      t.boolean :looked, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :expression_id
    add_index :notifications, :event_id
  end
end
