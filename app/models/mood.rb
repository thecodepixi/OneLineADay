class Mood < ApplicationRecord
  has_many :days
  has_many :journals, through: :days 

  validates :mood_type, presence: true 
end
