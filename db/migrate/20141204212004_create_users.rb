class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :email, :limit => 254
      t.string :password, :limit =>60
      t.string :first_name, :limit =>15
      t.string :last_name, :limit =>15
      t.date :birthday
      t.integer :gender, :limit => 1
      t.float :latitude_home
      t.float :longitude_home
      t.float :latitude_current
      t.float :longitutde_current
      t.timestamps
    end
  end

  def down
  	drop_table :users
  end
end
