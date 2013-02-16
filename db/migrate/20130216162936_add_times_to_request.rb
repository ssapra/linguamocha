class AddTimesToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :times, :text
  end
end
