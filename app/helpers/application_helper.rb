module ApplicationHelper

  #returns true when a session has been set
  def logged_in?
    true if session[:user_id]
  end 

  #persist current logged in User object
  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end 

end
