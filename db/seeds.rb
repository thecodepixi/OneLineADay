# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#CREATE MY DEMO USER 
User.create(name: 'Emily', username:'EmilyAnne', password: 'AdminUser')

#CREATE OTHER FAKE USERS
until User.all.count == 5
   User.create(name: Faker::Name.name, username: Faker::Games::Pokemon.name, password: "password") 
end 

#CREATE FAKE JOURNALS:
User.all.each do |user|
  4.times do 
    Journal.create(title: Faker::Book.title, mantra: Faker::Movies::HitchhikersGuideToTheGalaxy.marvin_quote, user_id: user.id)
  end 
end 

#CREATE MOODS
moods = ["happy", "sad", "energetic", "lonely", "depressed", "optimistic", "angry", "nervous", "stressed"]

moods.each do |mood|
  Mood.create(mood_type: mood) 
end 

#CREATE FAKE JOURNAL ENTRIES/DAYS 
Journal.all.each do |journal| 
  5.times do 
    day = journal.days.build 
    day.content = Faker::Hipster.sentence(word_count: 5)
    day.user = journal.user
    day.mood = Mood.all.sample 
    day.created_at = Faker::Date.between(from: 1.years.ago, to: Date.today)
    day.save 
  end 
end 