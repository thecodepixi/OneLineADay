class Day < ApplicationRecord
  belongs_to :user 
  belongs_to :mood 
  belongs_to :journal 

  validates :description, length: { maximum: 250, message: "Journal descriptions can only be 250   characters long." }, presence: true 
  validates :mood_id, presence: true

  def title_date 
    created_at.strftime("%A, %B %d, %Y")
  end 

end
