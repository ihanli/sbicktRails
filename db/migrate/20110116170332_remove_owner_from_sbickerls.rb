class RemoveOwnerFromSbickerls < ActiveRecord::Migration
  def self.up
    remove_column :sbickerls, :owner
  end

  def self.down
    add_column :sbickerls, :owner, :string
  end
end
