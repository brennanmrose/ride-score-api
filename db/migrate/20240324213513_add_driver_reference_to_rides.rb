class AddDriverReferenceToRides < ActiveRecord::Migration[7.1]
  def change
    add_reference :rides, :driver, index: true, foreign_key: true
  end
end
