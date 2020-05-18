class CreateArguments < ActiveRecord::Migration[5.2]
  def change
    create_table :arguments do |t|
      t.integer :target, null: false
      t.string :topic, null: false

      t.timestamps
    end
  end
end
