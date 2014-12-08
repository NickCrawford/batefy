class CreateOffers < ActiveRecord::Migration
  
  def up
    create_table :offers do |t|
      t.references :business
      t.integer :percentage
      t.timestamps
    end
  end

  def down
  	drop_table :offers
  end
end
