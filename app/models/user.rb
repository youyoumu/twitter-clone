# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, uniqueness: { case_sensitive: false },
                       length: { minimum: 4, maximum: 15 },
                       format: { with: /\A[a-zA-Z0-9_]+\z/,
                                 message: 'can only contain letters, numbers, and underscores' },
                       presence: true

  has_many :user_likes
  has_many :likes, through: :user_likes, source: :tweet
  has_many :user_followings
  has_many :followings, through: :user_followings, source: :following
end
