class CreatePunches < ActiveRecord::Migration
  def change
    create_table :punches do |t|
      t.integer :user_id
      t.date :punch_date
      t.float :number

      t.timestamps
    end
  end
end
