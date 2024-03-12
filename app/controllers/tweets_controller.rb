class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.includes(:user)
    @likes_count = UserLike.group(:like).count
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user

    if @tweet.save
      redirect_to tweet_path(@tweet)
    else
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @tweet_reply = Tweet.new
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, parent_attributes: [:id])
  end
end
