class ApplicationController < ActionController::Base
  helper_method :logged_in?, :not_logged_in? 

  #create session on login 
  def set_session(user)
    session[:user_id] = user.id 
  end 

  #returns true when a session has been set
  def logged_in?
    true if session[:user_id]
  end 

  #persist current logged in User object
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end 

  #restrict access and cause redirect if there is no session[:user_id]
  def not_logged_in?
    if !logged_in? 
      redirect_to root_path, alert: 'Please log in or create an account first. Thank you! '
    end 
  end 

# checks if current_user owns the current record.
  def allowed_access?(thing)
    #if 'thing' is a User and not the current_user 
    if thing.class == User && thing.id != current_user.id
      return redirect_to root_path, alert: "Sorry, you can only access your own account!"
    # if thing is not a user, and does not belong to current user 
    elsif thing.class!= User && thing.user != current_user
      redirect_to root_path, alert: "Sorry, it looks like that doesn't belong to you!"
    end 
  end 

end
