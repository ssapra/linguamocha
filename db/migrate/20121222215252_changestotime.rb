class Changestotime < ActiveRecord::Migration
  def change
    remove_column :requests, :time
    add_column :requests, :start_time, :time
    add_column :requests, :end_time, :time
  end
end
