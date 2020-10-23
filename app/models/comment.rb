class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  
  has_many :favorites
  has_many :favoriting_users, through: :favorites, source: :user 

  validates :message, presence: true, length: { maximum: 255 }
end
