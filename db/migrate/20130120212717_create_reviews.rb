class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :request_id
      t.string :body
      t.integer :vote

      t.timestamps
    end
  end
end
