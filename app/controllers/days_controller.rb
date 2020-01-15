class DaysController < ApplicationController

  def index 
    @journal = Journal.find(params[:journal_id])
  end 

  def show 
    @day = Day.find_by(id: params[:id])
    @user = @day.user 
  end 

  def new 
    @journal = Journal.find(params[:journal_id])
    @user = @journal.user 
    @day = @journal.days.build
  end 

  def create
    @day = Day.new(day_params)
    if @day.save 
      redirect_to days_path(@day)
    else 
      render 'days/new'
    end 
  end 

  private 

  def day_params 
    params.require(:day).permit(:journal_id, :user_id, :mood_id, :content)
  end 

end
