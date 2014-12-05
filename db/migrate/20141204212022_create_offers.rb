class CreateOffers < ActiveRecord::Migration
  
  def up
    create_table :offers do |t|
      t.references :businesses
      t.string :description
      t.string :image
      t.timestamps
    end
  end

  def down
  	drop_table :offers
  end
end
