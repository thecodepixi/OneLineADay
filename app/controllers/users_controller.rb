class UsersController < ApplicationController

  def index 
    if logged_in? 
      redirect_to user_path(current_user)
    end 
  end 

  def show
    @user = User.find_by(id: params[:id])
    allowed_access?(@user)
  end 

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      set_session(@user)
      redirect_to @user 
    else 
      redirect_to root_path, alert: "Username or Password not recognized. Please try again. (If you signed up using Facebook or GitHub, please Log In with that account.)"
    end 
  end 

  def logout
    session.delete :user_id

    redirect_to root_path
  end 

  def new
    if logged_in? 
      redirect_to root_path, notice: "You already have an account, silly!"
    end 
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
    @user = User.find_by(id: params[:id])
    allowed_access?(@user)
  end 
  
  def update
    @user = User.find_by(id: params[:id])
    allowed_access?(@user)
    if @user.update(user_params)
      redirect_to @user, notice: "Your account has been updated."
    else 
      render :edit
    end 
  end 

  def destroy
    @user = User.find(params[:id])
    allowed_access?(@user)
    session.delete :user_id 
    @user.days.delete 
    @user.journals.delete 
    @user.delete 

    redirect_to root_path, notice: "Your account has been deleted."
  end 

  private 

  def user_params
    params.require(:user).permit(:name,:username,:password)
  end 

end
