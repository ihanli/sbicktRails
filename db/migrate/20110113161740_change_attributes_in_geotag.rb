class ChangeAttributesInGeotag < ActiveRecord::Migration
  def self.up
    change_table :geotags do |t|
      t.rename :x, :lat
      t.rename :y, :lng
      t.rename :z, :alt
    end
  end

  def self.down
    change_table :geotags do |t|
      t.rename :lat, :x
      t.rename :lng, :y
      t.rename :alt, :z
    end
  end
end
