class CreateMySkills < ActiveRecord::Migration
  def change
    create_table :my_skills do |t|
      t.string :tag
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
