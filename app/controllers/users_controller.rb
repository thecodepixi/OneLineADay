class UsersController < ApplicationController

  def index 
  end 

  def show
    @user = User.find_by(id: params[:id])
  end 

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      set_session(@user)
      redirect_to user 
    else 
      redirect_to root_path, alert: "Username or Password incorrect. Please try again."
    end 
  end 

  def logout
  end 

  def new
    @user = User.new 
  end 
  
  def create 
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else 
      render :new
    end  
  end 

  def edit
  end 
  
  def update
  end 

  def delete
  end 

  private 

  def user_params
    params.require(:user).permit(:name,:username,:email,:password)
  end 

end
