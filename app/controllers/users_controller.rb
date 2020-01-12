class UsersController < ApplicationController

  def index 
  end 

  def show
    @user = User.find_by(id: params[:id])
  end 

  def login

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
