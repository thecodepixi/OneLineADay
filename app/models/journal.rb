class Journal < ApplicationRecord
  belongs_to :user
  has_many :entries 
  has_many :moods, through: :entries 

  validates :user_id, presence: true 
  validates :title, presence: true, length: { maximum: 20, message: "Title must be less than 20 characters long." }
  
end
