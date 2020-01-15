class ChangeDayContentsToDetails < ActiveRecord::Migration[6.0]
  def change
    rename_column :days, :content, :description 
  end
end
