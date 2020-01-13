class ApplicationController < ActionController::Base
  #create session on login 
  def set_session(user)
    session[:user_id] = user.id 
  end 

  #TODO checks if current_user owns the current record. Maybe this belongs in Users Controller?
  def owns_record?
    #figure this out later
  end 

end
