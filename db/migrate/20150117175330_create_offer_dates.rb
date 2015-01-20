class CreateOfferDates < ActiveRecord::Migration
  def change
    create_table :offer_dates do |t|
      t.integer   :offer_id
      t.integer 	:active_from
      t.integer   :start_time
      t.integer   :end_time
      t.timestamps
    end
  end
end
