class AddMaxCacheAgeToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :max_cache_age, :integer
  end
end
