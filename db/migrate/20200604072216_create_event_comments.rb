class CreateEventComments < ActiveRecord::Migration[5.2]
  def change
    create_table :event_comments do |t|
      t.references :user, null: false
      t.references :event, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
