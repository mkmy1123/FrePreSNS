class AddIsValidToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_valid, :boolean, default: false, null: false
  end
end
