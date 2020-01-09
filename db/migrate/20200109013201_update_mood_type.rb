class UpdateMoodType < ActiveRecord::Migration[6.0]
  def change
    remove_column :moods, :type, :string
    add_column :moods, :mood_type, :string
  end
end
