class CreateSubtags < ActiveRecord::Migration
  def change
    create_table :subtags do |t|
      t.references :tag
      t.string :name
      t.timestamps
    end
  end
end
