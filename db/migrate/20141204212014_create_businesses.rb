class CreateBusinesses < ActiveRecord::Migration
  def up
    create_table :businesses do |t|
      t.string :email, :limit => 254, :null => false
      t.string :password, :limit => 60, :null => false
      t.string :name, :limit =>50, :null => false
      t.float :latitude, :null => false
      t.float :longitude, :null => false
      t.string :website
      t.string :phone
      t.string :address
      t.timestamps
    end
  end

  def down
  	drop_table :businesses
  end
end
