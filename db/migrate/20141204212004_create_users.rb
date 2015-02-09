class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :email, :limit => 254, :null => false
      t.string :password_digest, :null => false
      t.string :name, :limit =>35
      t.integer :birthday
      t.integer :gender, :limit => 1
      t.string :address, :default=>""
      t.string :country, :default=>""
      t.string :city, :default=>""
      t.string :state, :default=>""
      t.string :zip, :default=>""
      t.string :image
      t.string :website
      t.string :phone
      t.float :latitude
      t.float :longitude
      t.float :latitude_current
      t.float :longitutde_current
      t.timestamps
    end
    add_attachment :users, :image
  end

  def down
  	drop_table :users
  end
end
