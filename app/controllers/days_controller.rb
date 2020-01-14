class DaysController < ApplicationController

  def index 
    @user = User.find(params[:user_id])
    @journal = @user.journals.find(params[:journal_id])
  end 

  def show 
    @day = Day.find_by(params[:id])
    @user = @day.user 
  end 

  def new 
    
  end 

end
