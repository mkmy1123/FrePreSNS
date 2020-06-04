class CreateParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :participations do |t|
      t.references :user, null: false
      t.references :event, null: false

      t.timestamps
    end
  end
end
