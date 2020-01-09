# One Line A Day Journal:
## Rails Portfolio Project for Flatiron School 

## Models:
- User
    - ~~has many journals~~
    - ~~has many entries, through journals~~
    - ~~has many moods, through entries ~~
    - can log in and log out, make journal entries, edit and delete their own entries
    - can log in and out with Facebook or Google
    - ~~has secure password~~
    - can only view/access their own journals and entries
    - ~~has name~~
    - ~~has username~~
    - ~~has email~~
- Journal
    - belongs to user
    - has many entries
    - has many moods through: entries
    - has a title
    - has a mantra
    - has a cover image (file upload)
    - journals cannot have more than one entry per day
    - has nested routes through user (`'user/:id/journals'` && `'user/:id/journal/:id'`)
- Entry
    - belongs to journal
    - belongs to mood
    - belongs to user
    - title defaults to the day the entry is made
    - users cannot make more than one entry per day, per journal. (probably handled by journal model ?)
    - has content, limited to 100 characters.
    - has a daily mood (to be chosen from a dropdown of set options) ((belongs to))
    - has one optional image (file upload)
    - has edit link
    - has delete link
    - has nested route through journal (IE: `'user/:id/journal/:id/entry/:id'`)
    - has show page, but no index (journal show page *is* an index of all entries)

    - Mood
        - has many entries
        - has many journals through: entries
        - has a type

    ## Necessary Helper Methods:

    - current_user
        - identifies current logged in user via `session[:user_id]`
        - stores user object for logged in user
    - logged_in?
        - returns true if `session[:user_id]`
    - owns_record?
        - returns true if `current_user.id` matches `params[:user_id]` of the current page
        - used for checking whether a user can access certain pages. If they are logged in but do not own the record, throw an error and send them back to their own index page.