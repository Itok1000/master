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

   
  has_many :authentications, dependent: :destroy
  # - UserモデルとAuthenticationモデルを作成して、外部ログインをサポート
  
  has_many :posts, dependent: :destroy
  # dependent: :destroyを記述することによって、destroy 時に関連づけられたモデルに対して destroy が実行されるようになる
  # 今回の場合では、ユーザーが削除されたときに、そのユーザーに関連するPostレコードも一緒に削除される

  has_many :favorites, dependent: :destroy
  # dependent: :destroyを記述することによって、destroy 時に関連づけられたモデルに対して destroy が実行されるようになる
  # 今回の場合では、掲示板が削除されたときに、そのユーザーに関連するFavoriteレコードも一緒に削除される
  has_many :comments, dependent: :destroy
  # dependent: :destroyを記述することによって、destroy 時に関連づけられたモデルに対して destroy が実行されるようになる
  # 今回の場合では、掲示板が削除されたときに、そのユーザーに関連するCommentsレコードも一緒に削除される
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  def own?(object)
    # own? メソッドについて
    # own? メソッド
    # あるオブジェクトが特定のユーザーに属しているかどうかを判定するために作られたインスタンスメソッド

    # インスタンスメソッド
    # クラスのインスタンスに対して呼び出すことができるメソッド
    # ユーザーオブジェクトと任意のオブジェクトを比較し、
    # そのオブジェクトの user_idがユーザーオブジェクトのidと一致するかどうかを確認する
    id == object&.user_id
    # id == object&.user_id の解説
    # id は現在のユーザーオブジェクトのID

    # object&.user_id
    # 与えられたオブジェクトの user_id を取得する
    # ここで、&.（セーフナビゲーション演算子）を使用することで、object が nil の場合でもエラーを発生させずに nil を返す
    # 例えば次のような使い方ができる
    # current_user.own?(comment)
    # この場合、current_user.id == comment&.user_id を比較することになり、
    # 特定のコメントが現在ログインしているユーザーが投稿したものであるかどうかを判定することができる# id == object&.user_id の解説
    # id は現在のユーザーオブジェクトのID

    # object&.user_id
    # 与えられたオブジェクトの user_id を取得する
    # ここで、&.（セーフナビゲーション演算子）を使用することで、object が nil の場合でもエラーを発生させずに nil を返す
    # 例えば次のような使い方ができる
    # current_user.own?(comment)
    # この場合、current_user.id == comment&.user_id を比較することになり、
    # 特定のコメントが現在ログインしているユーザーが投稿したものであるかどうかを判定することができる
  end
end
