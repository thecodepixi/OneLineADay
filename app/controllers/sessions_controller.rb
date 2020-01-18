class SessionsController < ApplicationController

  def create 
    # find User by their auth_hash details
    @user = User.find_or_initialize_by(uid: auth_hash[:extra][:raw_info][:id])
    # if User does not already exist in the DB, setup a new user account 
    if @user.id.nil? 
      if auth_hash[:provider] == "developer"
        @user.auth_hash = auth_hash[:info]
        @user.name = auth_hash[:info][:name]
        @user.username = auth_hash[:info][:name]
      elsif auth_hash[:provider] == "github"
        @user.auth_hash = auth_hash[:info]
        @user.name = auth_hash[:info][:name]
        @user.username = auth_hash[:info][:nickname]
      elsif auth_hash[:provider] == "facebook"
        @user.auth_hash = auth_hash[:info]
        @user.name = auth_hash[:info][:name]
        @user.username = auth_hash[:info][:name]
      end 
      # set password to a random integer string, because password is required. 
      # User can reset password after creating their account.
      @user.password = "#{rand 10**10}"
      @user.save 
    end 
    # log the user in by creating a user session 
    set_session(@user)

    # send user to their homepage 
    redirect_to @user 
  end 

  private 

  # this method creates a hash from the omniauth.auth hash containing their account details 
  def auth_hash
    request.env['omniauth.auth']
  end 

end
