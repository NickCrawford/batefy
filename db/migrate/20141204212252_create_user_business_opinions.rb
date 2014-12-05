class CreateUserBusinessOpinions < ActiveRecord::Migration
  def up
    create_table :user_business_opinions do |t|
      t.references :business
      t.references :user
      t.integer :opinion
      t.timestamps
    end
    add_index :user_business_opinions, ["business_id","user_id"]
  end

  def down
  	drop_table :user_business_opinions
  end
end
