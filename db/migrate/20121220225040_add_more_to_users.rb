class AddMoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :high_school, :string
    add_column :users, :college, :string
    add_column :users, :degree, :string
    add_column :users, :occupation, :string
  end
end
