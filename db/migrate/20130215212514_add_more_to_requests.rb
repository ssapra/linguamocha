class AddMoreToRequests < ActiveRecord::Migration
  def change
  	rename_column :requests, :location_address, :address
  	add_column :requests, :city, :string
  	add_column :requests, :state, :string
  	add_column :requests, :postal_code, :string
  end
end
