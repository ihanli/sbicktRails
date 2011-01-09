class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :lastname, :string
      t.column :firstname, :string
      t.column :nickname, :string
      t.column :hashed_password, :string
      t.column :email, :string
      t.column :salt, :string
 
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
