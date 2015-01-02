class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :baselines, :type, :baseline_type
  end
end
