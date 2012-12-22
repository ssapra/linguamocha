class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :sender_confirmation
      t.boolean :receiver_confirmation
      t.time :time
      t.date :date
      t.string :location

      t.timestamps
    end
  end
end
