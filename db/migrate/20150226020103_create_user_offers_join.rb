class CreateUserOffersJoin < ActiveRecord::Migration
  def change
    create_table :offers_users, :id=>false do |t|
    	t.references :user
    	t.references :offer
    end
    add_index :offers_users, ["user_id","offer_id"]
  end
end
