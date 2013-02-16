class AddDeadlineToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :deadline, :date
  end
end
