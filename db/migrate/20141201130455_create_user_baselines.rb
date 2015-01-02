class CreateUserBaselines < ActiveRecord::Migration
  def change
    create_table :user_baselines do |t|
      t.integer :user_id
      t.integer :baseline_id

      t.timestamps
    end
    add_index :user_baselines, :user_id
    add_index :user_baselines, :baseline_id
    add_index :user_baselines, [:user_id, :baseline_id], unique: true
  end
end
