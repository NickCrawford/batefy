class CreateBusinessesTagsJoin < ActiveRecord::Migration
  def up
    create_table :businesses_tags, :id => false do |t|
    	t.integer "business_id"
    	t.integer "tag_id"
    end
    add_index :businesses_tags, ["business_id", "tag_id"]
  end

  def down
  	drop_table :businesses_tags
  end
end
