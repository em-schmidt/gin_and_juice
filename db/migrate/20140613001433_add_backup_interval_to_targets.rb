class AddBackupIntervalToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :backup_interval, :integer
  end
end
