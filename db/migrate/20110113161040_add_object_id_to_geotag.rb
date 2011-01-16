class AddObjectIdToGeotag < ActiveRecord::Migration
  def self.up
    add_column :geotags, :object_id, :integer
  end

  def self.down
    remove_column :geotags, :object_id
  end
end
