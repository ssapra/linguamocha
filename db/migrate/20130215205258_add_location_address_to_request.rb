class AddLocationAddressToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :location_address, :string
  end
end
