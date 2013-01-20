class AddIDsToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :sender_id, :integer
    add_column :reviews, :receiver_id, :integer
  end
end
