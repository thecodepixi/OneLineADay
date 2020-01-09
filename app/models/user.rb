class User < ApplicationRecord
  has_secure_password 
  has_many :journals 
  has_many :entries, through: :journals
  has_many :moods, through: :entries  
end
