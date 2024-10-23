class User < ApplicationRecord
  authenticates_with_sorcery!
  # - password；最小で3文字以上必要（新規レコード作成もしくはcrypted_passwordカラムが更新される時のみ適応）
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  # - password_confirmation：値が空でないこと・passwordの値と一致すること（新規レコード作成もしくはcrypted_passwordカラムが更新される時のみ適応）
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  # - user_name：値が空でないこと・最大255文字以下であること
  validates :user_name, presence: true, length: { maximum: 255 }
  # - email：値が空でないこと・ユニークな値であること
  validates :email, presence: true, uniqueness: true
  # ユーザーが複数のpostレコードを持つことを示す
  has_many :posts, dependent: :destroy
  # dependent: :destroyを記述することによって、destroy 時に関連づけられたモデルに対して destroy が実行されるようになる
  # 今回の場合では、ユーザーが削除されたときに、そのユーザーに関連するBoardレコードも一緒に削除される
end
