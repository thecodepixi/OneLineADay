class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.integer :user_id
      t.integer :journal_id
      t.integer :mood_id 

      t.string :content 

      t.timestamps
    end
  end
end
