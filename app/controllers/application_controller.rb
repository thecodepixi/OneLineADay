class ApplicationController < ActionController::Base
  #create session on login 
  def set_session(user)
    session[:user_id] = user.id 
  end 

  #persist current logged in User object
  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end 

  #returns true when a session has been set
  def logged_in?
    true if session[:user_id]
  end 

  #TODO checks if current_user owns the current record 
  def owns_record?
    #figure this out later
  end 

end
