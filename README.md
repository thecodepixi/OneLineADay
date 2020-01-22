# One Line A Day Journal:
## Rails Portfolio Project for Flatiron School 

One Line A Day is a simplified journaling and mood tracker app. Similar to popular IRL 'One Line A Day' journals, you are limited to a specific number of characters (250) per journal entry. However, you can have multiple journals, with which you can track any number of parts of your life. Maybe you're a parent and you need a journal to track each of your children's growth and moods, or a student who wants a journal to track your feelings/learning for each subject you study. The possibilities are endless... 

You can create a native account, or log in using either Facebook or GitHub (enabled via OmniAuth). 

## To Run This App: 
*This app will be deployed on Heroku shortly...* 

However, you can fork and clone the repo and run using `rails s` 
Run `rails db:seed` first to use the included `seeds.rb` file to test things out, or feel free to create your own! 

## Routes/URI of Interest: 
Once you have your account up and running, here are a few things you might want to do: 
- Track your moods by clicking the 'View All of Your Moods' link on the homepage (**URI: /users/:id/moods**)
- To see all moods for a specific journal, you can navigate to **users/:id/journals/:id/moods** directly, or visit **/journals/:id/days** and click the link to view the mood summary for that journal. 
- If you need to edit your account, you can click the 'Edit Your Account' link on your account homepage. (Sorry, Facebook/Github users cannot utilize this feature *yet*)

## Contributing 
Fun! Yay! Have an idea for a way to expand the app, or found a bug? 
Make a new branch, make your changes, and submit a PR. Easy peasy lemon squeezy. 

## Project Stretch/Future Goals 
  - Allow OmniAuth accounts to edit account info (currently not possible due to password auth requirement and OmniAuth randomly generated passwords)
  - Color coded moods 
  - Moods graphs/data vis 
  - Better UI (nicer buttons, better styling, other fonts)
  - Photo upload option (to become a daily photo journal)
    - Gallery view for photo updates 


## License

Copyright 2019

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


