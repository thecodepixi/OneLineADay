class DaysController < ApplicationController
  before_action :logged_in? 
  before_action only: [:index, :new, :create] do 
    set_journal 
    allowed_access?(@journal)
  end
  before_action only: [:show, :edit, :update] do 
    set_day 
    allowed_access?(@day)
  end 

  def index 
  end 

  def show 
    @user = current_user
    @mood = @day.mood 
  end 

  def new 
    @user = @journal.user 
    already_updated?
    @day = Day.new 
    @mood = Mood.new 
  end 

  def create
    @user = @journal.user 
    @day = Day.new(day_params)
    if !params[:day][:mood][:mood_type].nil? && params[:day][:mood_id].blank?
      @mood = Mood.find_or_initialize_by(mood_type: params[:day][:mood][:mood_type])
      if @mood.save 
        @day.mood = @mood
      end 
    end 
    if @day.save 
      redirect_to journal_day_path(@journal,@day)
    else 
      render :new
    end 
  end 

  def edit 
    @mood = Mood.new 
  end 

  def update 
    @day = Day.find(params[:id])
    @day.update(day_params)
    # create a new mood, when mood text_field is filled in and mood collection_select is blank. 
    # ! If both are filled in, the dropdown is the default ! 
    if !params[:day][:mood][:mood_type].nil? && params[:day][:mood_id].blank?
      @mood = Mood.find_or_initialize_by(mood_type: params[:day][:mood][:mood_type])
      if @mood.save 
        @day.mood = @mood
      end 
    end 
    if @day.save
      return redirect_to journal_day_path(@day.journal,@day)
    else 
      render :edit
    end 
  end 

  def destroy
    day = Day.find(params[:id])
    journal = day.journal 
    day.destroy 

    redirect_to user_journal_path(journal.user, journal)
  end 

  private  

  def day_params 
    params.require(:day).permit(:journal_id, :user_id, :mood_id, :description)
  end 

  # check whether the user has already made their daily update for the journal
  def already_updated?
    if @journal.days.any? && @journal.days.last.created_at.today?
      redirect_to user_journal_path(@user, @journal), alert: "You've already made your entry for today. Try editing it instead!"
    end 
  end 

  def set_journal
    @journal ||= Journal.find_by(id: params[:journal_id])
  end 

  def set_day 
    @day ||= Day.find_by(id: params[:id])
  end   

end
