class MoodsController < ApplicationController
  before_action do 
    user = User.find_by(id: params[:user_id])
    allowed_access?(user)
  end 

  def index
    @user = User.find_by(id: params[:user_id])
    @moods = @user.moods 
  end 

  def show 
    @user = User.find_by(id: params[:user_id])
    @mood = Mood.find_by(id: params[:id])
  end 

  def journal_index 
    @journal = Journal.find_by(id: params[:journal_id])
    @user = User.find_by(id: params[:user_id])
    @moods = @journal.moods 
  end 

end
