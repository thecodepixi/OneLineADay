class SessionsController < ApplicationController

  # method for OmniAuth account creation and login
  def create 
    # find User by their auth_hash details
    @user = User.find_or_initialize_by(uid: auth_hash[:extra][:raw_info][:id])
    # if User does not already exist in the DB, create a new user account 
    if @user.id.nil? 
      # github auth
      if auth_hash[:provider] == "github"
        @user.auth_hash = auth_hash[:info]
        @user.name = auth_hash[:info][:name]
        @user.username = auth_hash[:info][:nickname]
      # facebook auth 
      elsif auth_hash[:provider] == "facebook"
        @user.auth_hash = auth_hash[:info]
        @user.name = auth_hash[:info][:name]
        # facebook accounts don't have 'nicknames', so reuse :name as username (remove spaces)
        @user.username = auth_hash[:info][:name].split.join
      end 
      # set password to a random string integer (9-10 digits long), b/c password is required. 
      # TO DO: Allow users to reset randomly generated password, or choose a password during account creation... 
      @user.password = "#{rand 10**10}"
      @user.save 
    end 
    # log the user in by creating a user session 
    set_session(@user)

    # send user to their homepage 
    redirect_to @user 
  end 

  private 

  # this method creates a hash from the omniauth.auth hash containing the account details 
  def auth_hash
    request.env['omniauth.auth']
  end 

end
