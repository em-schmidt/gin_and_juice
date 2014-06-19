class AddLastBackupToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :last_backup, :integer
  end
end
