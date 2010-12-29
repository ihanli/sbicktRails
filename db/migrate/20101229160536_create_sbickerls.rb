class CreateSbickerls < ActiveRecord::Migration
  def self.up
    create_table :sbickerls do |t|
      t.string :owner
      t.text :content
      t.string :visibility

      t.timestamps
    end
  end

  def self.down
    drop_table :sbickerls
  end
end
