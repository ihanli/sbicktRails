class CreateGeotags < ActiveRecord::Migration
  def self.up
    create_table :geotags do |t|
      t.float :x
      t.float :y
      t.float :z

      t.timestamps
    end
  end

  def self.down
    drop_table :geotags
  end
end
