class DaysController < ApplicationController

  def index 
    @user = User.find(params[:user_id])
    @journal = @user.journals.find(params[:journal_id])
  end 

end
