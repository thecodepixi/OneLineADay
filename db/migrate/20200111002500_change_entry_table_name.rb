class ChangeEntryTableName < ActiveRecord::Migration[6.0]
  def change
    rename_table :entries, :days 
  end
end
