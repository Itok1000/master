class Post < ApplicationRecord
    validates :title, presence: true, length: { maximum: 255 }
    validates :body, presence: true, length: { maximum: 65_535 }
    has_many :comments, dependent: :destroy

    mount_uploader :post_image, PostImageUploader

    belongs_to :user

    has_many :favorites, dependent: :destroy

    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
    end

    def self.ransackable_attributes(auth_object = nil)
      [ "body", "created_at", "id", "post_image", "recipe", "title", "updated_at", "user_id" ]
    end

    def self.ransackable_associations(auth_object = nil)
      [ "comments", "favorites", "user" ]
    end
end
