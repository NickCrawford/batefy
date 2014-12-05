class CreateBusinessUsers < ActiveRecord::Migration
  def change
    create_table :business_users do |t|

      t.timestamps
    end
  end
end
