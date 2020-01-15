class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create 
    @user = User.find_or_initialize_by(auth_hash: "#{auth_hash}") 
    if @user.id.nil? 
      @user.uid = auth_hash[:uid]
      @user.name = auth_hash[:info][:name]
      @user.username = auth_hash[:info][:name]
      #set password to a random integer string, because password is required 
      @user.password = "#{rand 10**10}"
      @user.save 
    end 
    set_session(@user)

    redirect_to @user 
  end 

  private 

  def auth_hash
    request.env['omniauth.auth']
  end 

end
