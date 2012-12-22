class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :request_id
      t.text :body
      t.boolean :sender_viewed
      t.boolean :receiver_viewed

      t.timestamps
    end
  end
end
