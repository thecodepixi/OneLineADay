class User < ApplicationRecord
  has_secure_password 

  validates :name, length: { in: 3..15, wrong_length: "Name must be between 3 and 15 characters long." }, presence: true
  validates :password, length: { in: 6..12, wrong_length: "Password must be between 6 and 12 characters long." }, presence: true 
  validates :username, uniqueness: true, presence: true 

  has_many :journals 
  has_many :days, through: :journals
  has_many :moods, through: :days  
end
  