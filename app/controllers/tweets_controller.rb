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
        render_content_blank_error
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
      render_error
    end
  end

  def set_tweets
    @tweets = Tweet.all.with_attached_tweet_pic.includes(:user).order(created_at: :desc)
    @likes_count = UserLike.group(:like).count
  end

  def render_show_error
    @tweet_reply = @tweet
    @tweet = @tweet.parent
    @likes_count = UserLike.where(like: @tweet).group(:like).count
    render :show, status: :unprocessable_entity
  end

  def render_content_blank_error
    flash.now[:error] =
      'tweet cannot be blank without a picture.'
    render_error
  end

  def render_index_error
    set_tweets
    render :index, status: :unprocessable_entity
  end

  def render_error
    if @tweet.parent.present?
      render_show_error
    else
      render_index_error
    end
  end
end
