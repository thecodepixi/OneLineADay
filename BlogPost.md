# Terminate! (or How to Destroy Associated Records in Rails)

One of the best things about Rails is ActiveRecord, and one of the best things about ActiveRecord is the ease with which you can associated different tables/database records. But what happens to a records associated data when it's deleted/destroyed? 

Let's say, for example, that you're building a Rails app that has users, allows those users to make blog_posts, and allows users to leave comments on blog_posts. 

In this scenario, your model structure might look something like this: 
``` ruby
    class User 
    	has_many :blogs
    	has_many :blog_posts, through: :blogs 
    end 
    
    class Blog
    	belongs_to :user 
    	has_many :blog_posts 
    end 
    
    class blog_posts
    	belongs_to :blog 
    	belongs_to :user 
    end 
```
In your database your `blogs` table will have a foreign-key column of `user_id`, and your `blog_posts` table with have a foreign-key column of `blog_id`. Your `blogs` table becomes a join-table between `users` and `blog_posts`. 

With the "magic" of active record, you'll be able to call `user.blog_posts` (where `user` is a particular instance of `User`), which will run an SQL query that looks something like this: 
``` SQL
    SELECT "blog_posts".* FROM "blog_posts" INNER JOIN "blogs" ON "blog_posts"."blog_id" = "blogs"."id" WHERE "blogs"."user_id" = ? LIMIT ?  [["user_id", <user.id>], ["LIMIT", 11]]
```
In this scenario the `User` now has many `blogs`, which may have any number of `blog_posts` which are attributed to that `User`. 

You give your `users` the option to `destroy` their account, warning them that if they delete their account their associated data will also be deleted (`blogs` and `blog_posts`). 

**But, is this actually true with the code we have so far?** 

It turns out, ActiveRecord does not default to deleting associated data when a record is deleted. This is actually a *very* good thing, for a lot of reasons. **However**, if we do want to make sure that data is deleted, there are a few things we can do to make this happen "auto-magically"...

First, we can use an ActiveRecord method `dependent`, set it to `destroy`, for `user.blogs` like this: 
``` ruby
    class User 
    	has_many :blogs, dependent: :destroy 
    	has_many :comments, through: :blog_posts 
    end 
```
This ensures that when a `users` record is deleted/destroyed from our database, the associated `blogs` will also be identified (`blogs WHERE user_id = user.id`) and destroyed. 

But what about their `blog_posts`? 

If you were to now query your database for `blog_posts WHERE user_id = user.id`, you would see that all of their comments are still in the database. That's not good! We don't need those anymore. So, how do we ensure that their `blog_posts` get deleted as well? 

Thinking about our data structure we know that a `blog_post` belongs to a `blog` and a `blog` belongs to a `user`. We can't directly access the `blog_posts` from the `User` model, but we know that because of the `has_many through:` relationship, that if a `blog_post` exists it is associated with a `user`, and the `blog` that the `blog_post` belongs to is associated to the *same user.* 

Because of this structure, we know that if a `user` is deleted and their `blogs` are deleted, we can safely delete and `blog_posts` associated with that `blog`. 

This means that we can add the same `dependent: :destroy` method for `blog.blog_posts` as we did with `user.blogs`: 
``` ruby
    class Blog
    	belongs_to :user 
    	has_many :blog_posts, dependent: :destroy 
    end
```
Now, if we had a `User` we deleted, the following things would happen: 

our `user#destroy` action will call 
``` ruby
    def destroy 
    	@user = User.find_by(id: <some user id>)
    	@user.destroy 
    
    	# probably a redirect would happen down here  
    end 
```
and SQL will fire off the following: 
``` SQL
    SELECT "blogs".* FROM "blogs" WHERE "blogs"."user_id" = ?  [["user_id", <user.id>]]
      Blog_post Load (0.2ms)  SELECT "blog_posts".* FROM "blog_posts" WHERE "blog_posts"."blog_id" = ?  [["blog_id", <blog.id>]]
      Blog_post Destroy (0.6ms)  DELETE FROM "blog_posts" WHERE "blog_posts"."id" = ?  [["id", <blog_post.id>]]
      # The above will happen for as many blog_posts exist for the associated blog 
      Blog Destroy (0.1ms)  DELETE FROM "blogs" WHERE "blogs"."id" = ?  [["id", <blog.id>]]
      User Destroy (1.2ms)  DELETE FROM "users" WHERE "users"."id" = ?  [["id", <user.id>]]
```
Et Voila! 

You have deleted not only your `user`, but all of their associated `user.blogs` and all of those associated `blog.posts`, just by adding 2 extra words to your code in 2 places. 

If you enjoyed this post, let me know! If there is another technique for this that you know of, I'd love to hear about it in the comments. 

xx Emily / TheCodePixi

### Bonus: 

There is an alternative way to deal with this situation, by writing a helper method that to `delete_user_data` 

It would look something like this: 
``` Ruby 
  def delete_user_data
    @user.blog_posts.destroy_all
    @user.blogs.destroy_all 
  end 
``` 
You could then utilize this helper method inside of the `user#destroy` action, in your `UsersController`: 

```Ruby 
    def destroy 
      @user = User.find_by(id: params[:id])
      delete_user_data
      @user.destroy 
    end 
``` 

I much prefer the method using `dependent: :destroy` but I can imagine scenarios where the helper method may be a more appropriate solution. 
