class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: 'Tweet', optional: true
  has_many :replies, class_name: 'Tweet', foreign_key: 'parent_id'

  validates :content, presence: true, length: { minimum: 1 }
end
