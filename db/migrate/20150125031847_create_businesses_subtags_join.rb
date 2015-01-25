class CreateBusinessesSubtagsJoin < ActiveRecord::Migration
  def change
    create_table :businesses_subtags, :id=> false do |t|
    	t.references :business
    	t.references :subtag
    end
    add_index :businesses_subtags, ["business_id", "subtag_id"]
  end
end
