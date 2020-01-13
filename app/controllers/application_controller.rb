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
    @user ||= User.find_by(id: session[:user_id])
  end 

    #TODO checks if current_user owns the current record. Maybe this belongs in Users Controller?
    def owns_record?
      # this is maybe insufficient for how I want to use this method but good enough for now
      user_id = nil
      if params[:user_id]
        user_id = params[:user_id]
      else 
        user_id = params[:id]
      end 
      current_user.id == user_id
    end 

end
