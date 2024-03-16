class TweetsController < ApplicationController
  def index
    set_tweets
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.content.blank?
      if @tweet.tweet_pic.attached?
        save_tweet
      else
        flash.now[:error] =
          'tweet cannot be blank without a picture.'
        set_tweets
        if @tweet.parent.present?
          @tweet_reply = @tweet
          @tweet = @tweet.parent
          @likes_count = UserLike.where(like: @tweet).group(:like).count
          render :show, status: :unprocessable_entity
        else
          render :index, status: :unprocessable_entity
        end
      end
    else
      save_tweet
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @tweet_reply = Tweet.new
    @likes_count = UserLike.where(like: @tweet).group(:like).count
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, :tweet_pic, parent_attributes: [:id])
  end

  def save_tweet
    if @tweet.save
      redirect_to tweet_path(@tweet)
    else
      set_tweets
      render :index, status: :unprocessable_entity
    end
  end

  def set_tweets
    @tweets = Tweet.all.includes(:user).order(created_at: :desc)
    @likes_count = UserLike.group(:like).count
  end
end
