class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :tag

      t.timestamps
    end
  end
end
