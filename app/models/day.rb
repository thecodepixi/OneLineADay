class Day < ApplicationRecord
  belongs_to :user 
  belongs_to :mood 
  belongs_to :journal 

  validates :content, length: { maximum: 150, message: "Journal entries can only be up to 150 characters." }

  def title_date 
    created_at.strftime("%A, %B %d, %Y")
  end 

end
