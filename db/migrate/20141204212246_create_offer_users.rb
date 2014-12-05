class CreateOfferUsers < ActiveRecord::Migration
  def change
    create_table :offer_users do |t|

      t.timestamps
    end
  end
end
