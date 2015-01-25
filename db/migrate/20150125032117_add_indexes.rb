class AddIndexes < ActiveRecord::Migration
  def change
  	add_index :subtags, ["tag_id"]
  	add_index :offer_dates, ["offer_id"]
  end
end
