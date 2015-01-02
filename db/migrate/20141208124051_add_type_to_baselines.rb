class AddTypeToBaselines < ActiveRecord::Migration
  def change
    add_column :baselines, :type, :string
  end
end
