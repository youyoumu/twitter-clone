class UsersController < ApplicationController
  def show
    if User.exists?(params[:id])
      @user = User.includes(:tweets).find(params[:id])
      @likes_count = UserLike.group(:like).count
    else
      redirect_to root_path
    end
  end
end
