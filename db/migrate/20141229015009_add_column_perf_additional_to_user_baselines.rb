class AddColumnPerfAdditionalToUserBaselines < ActiveRecord::Migration
  def change
  	add_column :user_baselines, :perf_additional, :string
  end
end
