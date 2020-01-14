class JournalsController < ApplicationController

  def index 
    if !logged_in?
      redirect_to root_path
    end 

    @user = current_user 
    @journals = current_user.journals
  end 

  def show 
    @user = User.find_by(id: params[:user_id])
    @journal = Journal.find_by(id: params[:id])
  end 

  def new
    @user = User.find(params[:user_id])
    @journal = Journal.new
  end 

  def create
    @user = User.find(params[:user_id])
    @journal = Journal.new(journal_params)
    if @journal.save 
      redirect_to user_journals_path(@user)
    else 
      render :new 
    end 
  end 

  def edit
    @user = User.find_by(id: params[:user_id])
    @journal = Journal.find_by(id: params[:id])
  end 

  def update
    @user = User.find_by(id: params[:user_id])
    @journal = Journal.find_by(id: params[:id])
    if @journal.update(journal_params)
      redirect_to user_journal_path(@user, @journal), notice: "Your journal was successfully updated."
    else 
      render :edit
    end 
  end 

  def destroy
    @user = User.find_by(params[:user_id])
    @journal = Journal.find(params[:id])
    @journal.delete 

    redirect_to user_journals_path(@user), notice: "Journal successfully deleted."
  end 

  private 

  def journal_params
    params.require(:journal).permit(:title, :mantra, :user_id)
  end 

end
