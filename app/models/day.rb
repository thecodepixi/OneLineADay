class Day < ApplicationRecord
  # join table between users and their journals, and users, their journals and their moods
  belongs_to :user 
  belongs_to :mood
  belongs_to :journal 

  validates :description, length: { maximum: 250, message: "Journal descriptions can only be 250 characters long." }, presence: true 
  validates :mood_id, presence: true

  # helper method to show the day 'title' which is just the formatted 'created_at' date
  def title_date 
    created_at.strftime("%A, %B %d, %Y")
  end 

end
