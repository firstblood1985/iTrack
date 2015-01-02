class ChangeDataTypeForUserBaselinesPerf < ActiveRecord::Migration
  def change
  	 change_table :user_baselines do |t|
      t.change :perf, :string
    end
  end
end
