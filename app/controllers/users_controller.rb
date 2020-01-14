class UsersController < ApplicationController

  def index 
    if logged_in? 
      redirect_to user_path(current_user)
    end 
  end 

  def show
    @user = User.find_by(id: params[:id])
  end 

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      set_session(@user)
      redirect_to @user 
    else 
      redirect_to root_path, alert: "Username or Password not recognized. Please try again."
    end 
  end 

  def logout
    session.delete :user_id

    redirect_to root_path
  end 

  def new
    @user = User.new 
  end 
  
  def create 
    @user = User.new(user_params)
    if @user.save
      set_session(@user)
      redirect_to @user
    else 
      render :new
    end  
  end 

  def edit
    if current_user.id = params[:id]
      @user = current_user
    else 
      redirect_to root_path, alert: "You must be logged in to visit that page. Please log in and try again."
    end 
  end 
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user, notice: "Your account has been updated."
    else 
      render :edit
    end 
  end 

  def destroy
    @user = User.find(params[:id])
    session.delete :user_id 
    @user.delete 

    redirect_to root_path, notice: "Your account has been deleted."
  end 

  private 

  def user_params
    params.require(:user).permit(:name,:username,:password)
  end 

end
