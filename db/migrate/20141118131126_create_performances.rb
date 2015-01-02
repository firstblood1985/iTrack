class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.integer :user_id
      t.integer :wod_id
      t.string :performance

      t.timestamps
    end
  end
end
