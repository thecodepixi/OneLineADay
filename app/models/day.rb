class Day < ApplicationRecord
  belongs_to :user 
  belongs_to :mood 
  belongs_to :journal 

  validates :description, length: { maximum: 150, message: "Journal descriptions can only be up to 150 characters long." }, presence: true 

  def title_date 
    created_at.strftime("%A, %B %d, %Y")
  end 

end
