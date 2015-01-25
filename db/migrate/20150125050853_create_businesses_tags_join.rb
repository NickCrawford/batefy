class CreateBusinessesTagsJoin < ActiveRecord::Migration
  def change
  	create_table :businesses_tags, :id=> false do |t|
    	t.references :business
    	t.references :tag
    end
    add_index :businesses_tags, ["business_id", "tag_id"]
  end
end
