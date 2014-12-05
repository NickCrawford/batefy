class CreateOfferDates < ActiveRecord::Migration
  def up
    create_table :offer_dates do |t|
      t.references :offer
      t.date :date
      t.time :time_start
      t.time :time_end
      t.timestamps
    end
  end

  def down
  	drop_table :offer_dates
  end
end
