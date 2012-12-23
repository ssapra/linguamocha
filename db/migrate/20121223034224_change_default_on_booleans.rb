class ChangeDefaultOnBooleans < ActiveRecord::Migration
  def up
    change_column :requests, :sender_confirmation, :boolean, :default => false
    change_column :requests, :receiver_confirmation, :boolean, :default => false
    change_column :messages, :sender_viewed, :boolean, :default => false
    change_column :messages, :receiver_viewed, :boolean, :default => false
  end

  def down
    change_column :requests, :sender_confirmation, :boolean, :default => nil
    change_column :requests, :receiver_confirmation, :boolean, :default => nil
    change_column :messages, :sender_viewed, :boolean, :default => nil
    change_column :messages, :receiver_viewed, :boolean, :default => nil
  end
end
