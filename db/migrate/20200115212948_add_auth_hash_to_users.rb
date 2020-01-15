class AddAuthHashToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :auth_hash, :string 
    add_column :users, :uid, :string
  end
end
