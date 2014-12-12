class AddPasswordDigestToBusinessAndUser < ActiveRecord::Migration
  def up
  	remove_column :businesses, :password
  	add_column :businesses, :password_digest, :string
  	remove_column :users, :password
  	add_column :users, :password_digest, :string
  end

  def down
  	add_column :businesses, :password, :string
  	remove_column :businesses, :password_digest
  	add_column :users, :password, :string
  	remove_column :users, :password_digest
  end
end
