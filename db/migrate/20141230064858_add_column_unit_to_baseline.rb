class AddColumnUnitToBaseline < ActiveRecord::Migration
  def change
  	add_column :baselines, :unit, :string
  end
end
