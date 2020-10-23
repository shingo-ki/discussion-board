class User < ApplicationRecord
    
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
    
    has_many :subjects
    has_many :comments
    has_many :favorites
    has_many :favoritings, through: :favorites, source: :comment
    
    
    def favorite(comment)
        self.favorites.find_or_create_by(comment_id: comment.id)
    end
    
    def unfavorite(comment)
        favorite = self.favorites.find_by(comment_id: comment.id)
        favorite.destroy if favorite
    end    
        
    def favoriting?(comment)
        self.favoritings.include?(comment)
    end
end
