class Entry < ApplicationRecord
  belongs_to :user 
  belongs_to :mood 
  belongs_to :journal 
end
