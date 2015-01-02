class AddPerfToUserBaselines < ActiveRecord::Migration
  def change
    add_column :user_baselines, :perf, :integer
  end
end
