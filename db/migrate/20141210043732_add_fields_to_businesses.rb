class AddFieldsToBusinesses < ActiveRecord::Migration
  def change
  	add_column :businesses, :country, :string
  	add_column :businesses, :city, :string
  	add_column :businesses, :state, :string
  	add_column :businesses, :zip, :string
  	add_column :businesses, :image, :string
  end
end
