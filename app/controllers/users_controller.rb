class UsersController < ApplicationController

  before_action :not_logged_in?, except: [:index, :login, :new, :create]

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
      return redirect_to @user 
    else 
      redirect_to root_path, alert: "Username or Password not recognized. Please try again. (If you signed up using Facebook or GitHub, please Log In using that option below.)"
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
      return redirect_to @user
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
    # authenticate the user
    if @user.authenticate(params[:user][:password])
      #update their account
      if @user.update(user_params)
        # and redirect back to their homepage 
        return redirect_to @user, notice: 'Your account has been updated'
      else 
        #on errors, render edit page
        return render :edit 
      end 
    else 
      #when user does not authenticate, redirect back to edit page and alert
      redirect_to edit_user_path(@user), alert: 'Incorrect Password. Please enter your password to update your account.'
    end 
  end 

  def destroy
    @user = User.find(params[:id])
    session.delete :user_id 
    # on destroy, user journals and days are destroyed automatically 
    @user.destroy 

    redirect_to root_path, notice: "Your account has been deleted. We miss you already!"
  end 

  private 

  def user_params
    params.require(:user).permit(:name,:username,:password)
  end 

end
