class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :tag
      t.integer :user_id

      t.timestamps
    end
  end
end
