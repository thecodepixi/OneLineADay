class Journal < ApplicationRecord
  belongs_to :user
  has_many :entries 
  has_many :moods, through: :entries 
end
