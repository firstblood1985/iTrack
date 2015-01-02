class CreateBasicInfos < ActiveRecord::Migration
  def change
    create_table :basic_infos do |t|
      t.integer :user_id
      t.date :date_of_birth
      t.integer :height
      t.integer :weight

      t.timestamps
    end
    add_index :basic_infos, [:user_id]
  end
end
