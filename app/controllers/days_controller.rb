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
    @day = Day.new 
    @mood = Mood.new 
  end 

  def create
    @journal = Journal.find(params[:journal_id])
    @user = @journal.user 
    @day = Day.new(day_params)
    if !params[:day][:mood][:mood_type].nil? && params[:day][:mood_id].blank?
      @mood = Mood.find_or_initialize_by(mood_type: params[:day][:mood][:mood_type])
      @day.mood = @mood
    end 
    if @day.save 
      redirect_to journal_day_path(@journal,@day)
    else 
      render :new
    end 
  end 

  def edit 
    @day = Day.find_by(id: params[:id])
    @mood = Mood.new 
  end 

  def update 
    @day = Day.find(params[:id])
    @day.update(day_params)
    if !params[:day][:mood][:mood_type].nil? && params[:day][:mood_id].blank?
      @mood = Mood.find_or_initialize_by(mood_type: params[:day][:mood][:mood_type])
      @day.mood = @mood
    end 
    if @day.save
      redirect_to journal_day_path(@day.journal,@day)
    else 
      render :edit
    end 
  end 

  private 

  def day_params 
    params.require(:day).permit(:journal_id, :user_id, :mood_id, :description)
  end 

end
