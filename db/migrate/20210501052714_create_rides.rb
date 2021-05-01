class CreateRides < ActiveRecord::Migration[6.1]
  def change
    create_table :rides do |t|
      t.string :status
      t.float :payout
      t.float :distance_km
      t.float :rating
      t.datetime :completed_at
      t.string :pickup_location
      t.string :drop_location
      t.belongs_to :users
      t.belongs_to :drivers

      t.timestamps
    end
  end
end
