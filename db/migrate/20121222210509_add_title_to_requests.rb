class AddTitleToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :title, :string
  end
end
