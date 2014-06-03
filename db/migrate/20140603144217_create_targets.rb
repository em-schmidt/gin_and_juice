class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :host
      t.string :path

      t.timestamps
    end
  end
end
