class MoodsController < ApplicationController
  before_action :not_logged_in? 

  before_action do 
    user = User.find_by(id: params[:user_id])
    allowed_access?(user)
  end 

  def index
    @user = User.find_by(id: params[:user_id])
    @moods = @user.moods.group('mood_type')
  end 

  def show 
    @user = User.find_by(id: params[:user_id])
    @mood = Mood.find_by(id: params[:id])
    @days = @user.days.where('mood_id = ?', @mood.id).order('created_at desc')
  end 

  def journal_index 
    @journal = Journal.find_by(id: params[:journal_id])
    @user = User.find_by(id: params[:user_id])
    @moods = @journal.moods 
  end 

end
