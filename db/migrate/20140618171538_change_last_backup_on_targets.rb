class ChangeLastBackupOnTargets < ActiveRecord::Migration
  def change
      change_column :targets, :last_backup, :integer, :default => 0, :null => false
  end
end
