class CreateChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :checks do |t|
      t.references :user, null: false
      t.references :argument, null: false

      t.timestamps
    end
  end
end
