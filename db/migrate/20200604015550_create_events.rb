class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :all_day, default: false, null: false
      t.text :description
      t.references :argument, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
