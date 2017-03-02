class TweetsController < ApplicationController

  # before_action :move_to_index, except: :index
  def index
    @tweets = Tweet.includes(:user).order('id DESC').page(params[:page]).per(5)
  end

  def new
  end

  def create
    Tweet.create(tweet_params)
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
     tweet = Tweet.find(params[:id])
     tweet.update(tweet_params) if current_user.id == tweet.user_id
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if current_user.id == tweet.user_id
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user)
  end

  private
  def tweet_params
  params.permit(:image, :text).merge(user_id: current_user.id)
  end

  def move_to_index
  redirect_to root_path unless user_signed_in?
  end
end
