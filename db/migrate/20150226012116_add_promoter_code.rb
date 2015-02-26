class AddPromoterCode < ActiveRecord::Migration
  def change
  	add_column :businesses, :promoter_code, :integer
  end
end
