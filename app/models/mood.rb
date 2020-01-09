class Mood < ApplicationRecord
  has_many :entries
  has_many :journals, through: :entries 
end
