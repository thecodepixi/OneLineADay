class JournalsController < ApplicationController

  def index 
    @user = current_user 
    @journals = current_user.journals
  end 

  def show 
  end 

  def new
    @user = User.find(params[:user_id])
    @journal = Journal.new
  end 

  def create
    @user = User.find(params[:user_id])
    @journal = Journal.new(journal_params)
    if @journal.save 
      redirect_to user_path(@user)
    else 
      render :new 
    end 
  end 

  def edit
  end 

  def update
  end 

  def destroy
  end 

  private 

  def journal_params
    params.require(:journal).permit(:title, :mantra, :user_id)
  end 

end
