class AddDateToUserBaselines < ActiveRecord::Migration
  def change
    add_column :user_baselines, :perf_date, :date
  end
end
