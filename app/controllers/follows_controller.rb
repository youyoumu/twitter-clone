class FollowsController < ApplicationController
  def create
    return if current_user == User.find(params[:user_id])

    current_user.followings << User.find(params[:user_id])
  rescue ActiveRecord::RecordNotUnique
  end

  def destroy
    current_user.followings.delete(User.find(params[:user_id]))
  end
end
