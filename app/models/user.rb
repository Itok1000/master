class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :user_name, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :email, presence: true, uniqueness: true


  has_many :authenticates, dependent: :destroy
  accepts_nested_attributes_for :authenticates

  has_many :posts, dependent: :destroy

  has_many :favorites, dependent: :destroy

  has_many :comments, dependent: :destroy

  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  enum role: { general: 0, admin: 1 }

  def own?(object)
    id == object&.user_id
  end
end
