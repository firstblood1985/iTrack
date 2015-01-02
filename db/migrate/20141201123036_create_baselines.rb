class CreateBaselines < ActiveRecord::Migration
  def change
    create_table :baselines do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
