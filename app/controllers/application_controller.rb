class ApplicationController < ActionController::Base
  helper_method :logged_in? 

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

    # checks if current_user owns the current record.
    def allowed_access?(thing, user = current_user)
      if thing.class == User && thing.id != user.id
        redirect_to root_path, alert: "Sorry, you can only access your own account!"
      elsif thing.user != user
        redirect_to root_path, alert: "Sorry, it looks like that doesn't belong to you!"
      end 
    end 

end
