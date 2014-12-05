class CreateUserOfferOpinions < ActiveRecord::Migration
  def up
    create_table :user_offer_opinions do |t|
      t.references :offer
      t.references :user
      t.integer :opinion	
      t.timestamps 
    end
    add_index :user_offer_opinions, ["offer_id","user_id"]
  end

  def down
  	drop_table :user_offer_opinions
  end
end
