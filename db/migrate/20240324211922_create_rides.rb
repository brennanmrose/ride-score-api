class CreateRides < ActiveRecord::Migration[7.1]
  def change
    create_table :rides do |t|
      t.string :start_address, null: false
      t.string :destination_address, null: false

      t.timestamps
    end
  end
end
