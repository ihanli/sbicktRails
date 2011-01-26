class AddGeotagIdToSbickerls < ActiveRecord::Migration
  def self.up
    add_column :sbickerls, :geotag_id, :int
  end

  def self.down
    remove_column :sbickerls, :geotag_id
  end
end
