class RemoveSbickerlIdFromGeotags < ActiveRecord::Migration
  def self.up
    remove_column :geotags, :sbickerl_id
  end

  def self.down
    add_column :geotags, :sbickerl_id, :int
  end
end
