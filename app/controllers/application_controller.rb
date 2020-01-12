class ApplicationController < ActionController::Base
  #create session on login 
  def set_session(user)
    session[:user_id] = user.id 
  end 

  #persist current logged in User object
  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end 

  

end
