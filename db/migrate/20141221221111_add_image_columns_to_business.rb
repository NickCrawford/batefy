class AddImageColumnsToBusiness < ActiveRecord::Migration
  
  def up
  	add_attachment :businesses, :image
  	remove_column :businesses, :image
  end

  def down
  	remove_attachment :businesses, :image
  end

end
