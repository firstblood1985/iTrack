class RemoveUniqueIndexOnUserBaselines < ActiveRecord::Migration
  def change
  	remove_index :user_baselines, :column=>[:user_id,:baseline_id]
  end
end
