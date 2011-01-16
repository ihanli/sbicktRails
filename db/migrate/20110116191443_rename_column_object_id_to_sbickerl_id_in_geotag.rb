class RenameColumnObjectIdToSbickerlIdInGeotag < ActiveRecord::Migration
  def self.up
    change_table :geotags do |t|
      t.rename :object_id, :sbickerl_id
    end
  end

  def self.down
    change_table :geotags do |t|
      t.rename :sbickerl_id, :object_id
    end
  end
end
