class JournalsController < ApplicationController

  before_action :not_logged_in? 

  def index 
    @user = User.find_by(id: params[:user_id])
    @journals = @user.journals.order('created_at desc')

    allowed_access?(@user)
  end 

  def show 
    @user = User.find_by(id: params[:user_id])
    @journal = Journal.find_by(id: params[:id])
    allowed_access?(@journal)
    @recent_days = @journal.days.order('created_at desc').limit(5)
  end 

  def new
    @user = User.find(params[:user_id])
    allowed_access?(@user)
    @journal = Journal.new
  end 

  def create
    @user = User.find(params[:user_id])
    allowed_access?(@user)
    @journal = Journal.new(journal_params)
    if @journal.save 
      return redirect_to user_journal_path(@user, @journal)
    else 
      render :new 
    end 
  end 

  def edit
    @journal = Journal.find_by(id: params[:id])
    @user = @journal.user 
    allowed_access?(@journal)
  end 

  def update
    @journal = Journal.find_by(id: params[:id])
    @user = User.find_by(params[:journal][:user_id])
    allowed_access?(@journal)
    if @journal.update(journal_params)
      return redirect_to user_journal_path(@user, @journal), notice: "Your journal was successfully updated."
    else 
      render :edit
    end 
  end 

  def destroy
    @user = User.find_by(params[:user_id])
    @journal = Journal.find(params[:id])
    allowed_acess?(@journal)
    @journal.delete 

    redirect_to user_journals_path(@user), notice: "Journal successfully deleted."
  end 

  private 

  def journal_params
    params.require(:journal).permit(:title, :mantra, :user_id)
  end 

end
