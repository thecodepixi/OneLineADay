# One Line A Day Journal:
## Rails Portfolio Project for Flatiron School 

## Models:
  ### User
    - can make, edit, and delete journal entries/days
    - can only view/access their own journals and entries
  ### Journal
    - has a cover image (file upload)
    - journals cannot have more than one entry per day
  ### Day (Journal Entries)
    - users cannot make more than one entry per day, per journal. (probably handled by journal model ?)
    - has one optional image (file upload)
    - has edit link
    - has delete link
  ### Mood 
    - index page shows all of users historical moods
    - show page lists journal days tagged with that mood, sorted by journal 

  ## Necessary Helper Methods:  
    - **Need method for redirect and alert when user is not logged in** 

