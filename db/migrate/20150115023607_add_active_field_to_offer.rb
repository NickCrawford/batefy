class AddActiveFieldToOffer < ActiveRecord::Migration
  
  def change
  	add_column :offers, :active, :integer
  end

end
