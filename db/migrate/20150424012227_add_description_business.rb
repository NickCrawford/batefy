class AddDescriptionBusiness < ActiveRecord::Migration
  
  def change
  	add_column :businesses, :description, :string
  end

end
