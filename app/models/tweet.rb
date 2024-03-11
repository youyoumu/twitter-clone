# == Schema Information
#
# Table name: tweets
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  content    :text
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: 'Tweet', optional: true
  has_many :replies, class_name: 'Tweet', foreign_key: 'parent_id'
  has_many :user_likes, foreign_key: 'like'
  has_many :likers, through: :user_likes, source: :user

  validates :content, presence: true, length: { minimum: 1 }
end
