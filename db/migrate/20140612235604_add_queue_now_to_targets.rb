class AddQueueNowToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :queue_now, :boolean
  end
end
