Journal.destroy_all 
Mood.destroy_all

# User.create(name: 'Demo User', username:'DemoUser', password: 'password')

#CREATE FAKE JOURNALS:
User.all.each do |user|
  until user.journals.count == 5 do 
    Journal.create(title: Faker::Book.title, mantra: Faker::Movie.quote, user_id: user.id)
  end 
end 

#CREATE MOODS
moods = ["energetic", "lonely", "depressed", "optimistic", "angry", "nervous", "stressed", "joyful", "hopeful", "vibrant", "tired"]

moods.each do |mood|
  Mood.create(mood_type: mood) 
end 

#CREATE FAKE DAYS WITH RANDOM MOODS AND DATES
Journal.all.each do |journal| 
  until journal.days.count == 10 do 
    day = journal.days.build 
    day.description = Faker::Hipster.sentence(word_count: 5)
    day.user = journal.user
    day.mood = Mood.all.sample 
    day.created_at = Faker::Date.between(from: 2.years.ago, to: Date.today)
    day.save 
  end 
end 