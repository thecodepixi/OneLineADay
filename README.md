# One Line A Day Journal:
## Rails Portfolio Project for Flatiron School 

## Models:
- User
    - ~~has many journals~~
    - ~~has many entries, through journals~~
    - ~~has many moods, through entries~~
    - ~~can log in and log out, edit and delete account~~
    - can make, edit, and delete journals 
    - can make, edit, and delete journal entries 
    - can log in and out with Facebook or Google
    - ~~has secure password~~
    - can only view/access their own journals and entries
    - ~~has name~~
    - ~~has username~~
    - ~~has email~~
- Journal
    - ~~belongs to user~~
    - ~~has many entries~~
    - ~~has many moods through: entries~~
    - ~~has a title~~
    - ~~has a mantra~~
    - has a cover image (file upload)
    - journals cannot have more than one entry per day
    - ~~has nested routes through user (`'user/:id/journals'` && `'user/:id/journal/:id'`)~~
- Entry
    - ~~belongs to journal~~
    - ~~belongs to mood~~
    - ~~belongs to user~~
    - title defaults to the day the entry is made
    - users cannot make more than one entry per day, per journal. (probably handled by journal model ?)
    - ~~has content, limited to 100 characters.~~
    - ~~has a daily mood (to be chosen from a dropdown of set options) ((belongs to))~~
    - has one optional image (file upload)
    - has edit link
    - has delete link
    - non-nested routes 
    - has show page, but no index (journal show page *is* an index of all entries)
  - Mood
    - ~~has many entries~~
    - ~~has many journals through: entries~~
    - ~~has a type~~

    ## Necessary Helper Methods:
  Application
    - not_logged_in?
      - uses logged_in? function
      - if user is not logged_in? redirects to root_path 
      - use in all logged_in user-only views
    - current_user
      - identifies current logged in user via `session[:user_id]`
      - stores user object for logged in user
    - owns_record?
        - returns true if `current_user.id` matches `params[:user_id]` of the current page
        - used for checking whether a user can access certain pages. If they are logged in but do not own the record, throw an error and send them back to their own index page.    
    - set_session(user)
      - takes user as argument
      - adds their user_id to the session    

    ## Views / Routes
    ### Root 
      - Main login page (user#index) 
    
    ### User
      - Sign Up (user#new) (+ user#create)
      - Log Out (user#logout) (link in navbar)
      - Show (user#show)
      - Edit (user#edit) (+ user#update)
      - Delete (user#destroy)

    ### Journals
      - Index (journal#index)
      - Show (journal#show)
      - New (journal#new) (+ journal#create)
      - Edit (journal#edit) (+ journal#update)
      - Delete (journal#delete)

    ### Entries 
      - Show (entry#show)
      - New (entry#new) (+ entry#create)
      - Edit (entry#edit) (+ entry#update)
      - Delete (entry#delete)

    ### Partials
      - User _form
      - Entry _form
      - Journal _form 

    ### Layouts
      - Main layout (header + footer)
      - Journal layout
      - Entry layout 