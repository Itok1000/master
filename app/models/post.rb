class Post < ApplicationRecord
    # validatesメソッドは、各カラムにバリデーションを設定するために使用
    # presence: trueは値が空でないことを確認し、length: { maximum: *** } は文字数の最大値を制限する
    validates :title, presence: true, length: { maximum: 255 }
    # 65_535という書き方は、数値を読みやすくするためにアンダースコアを使用しており、これは65,535と同じ意味
    validates :body, presence: true, length: { maximum: 65_535 }
    # belongs_to :userとは、PostモデルがUserモデルに属していることを示す。
    # この記述により、Postモデルの各レコードはUserモデルのレコードに関連付けられることになる


    has_many :comments, dependent: :destroy
    # dependent: :destroyを記述することによって、destroy 時に関連づけられたモデルに対して destroy が実行されるようになる
    # 今回の場合では、掲示板が削除されたときに、そのユーザーに関連するCommentレコードも一緒に削除される

    mount_uploader :post_image, PostImageUploader
    # 下記の記述を加えることで、Postモデルに対して CarrierWave の アップローダークラス（PostImageUploader）をマウントする
    # これにより、Postモデルのインスタンスで post_image という属性を持つことができ、画像のアップロードや取得が簡単に行えるようになる
    # また、上記を記述することにより、CarrierWave が提供するアップロードされた画像のURLを取得することができるようになる
    # (今回の課題の場合 post_image_url メソッドを使用して、画像のURLを取得できるようになる)
    # ※CarrierWaveがモデルに対して動的にメソッドを追加し、ファイルの保存場所やURLを管理する機能を提供するため

    # この設定により、Postモデルは画像のアップロード機能を持ち、ビューで画像を表示するためのURLを生成することが可能となる
    belongs_to :user

    has_many :favorites, dependent: :destroy
    # dependent: :destroyを記述することによって、destroy 時に関連づけられたモデルに対して destroy が実行されるようになる
    # 今回の場合では、掲示板が削除されたときに、そのユーザーに関連するFavoriteレコードも一緒に削除される
    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
    end
    # def favorited_by?(user)メソッド
    # このコードは、Postモデルにfavorited_by?(user)メソッドを追加
    # 指定されたユーザが特定の投稿（Postインスタンス）をいいねしているかどうかを判定

    has_many :feedbacks, dependent: :destroy
    # dependent: :destroyを記述することによって、destroy 時に関連づけられたモデルに対して destroy が実行されるようになる
    
    # Ransack needs attributes explicitly allowlisted as searchableとエラーが出た時に追記
    # Ransackで検索を行う属性を明示的に指定する必要があるため,Postモデルにransackable_attributesメソッドを追加し、
    # 検索可能な属性を定義しなければならない
    def self.ransackable_attributes(auth_object = nil)
      [ "body", "created_at", "id", "post_image", "recipe", "title", "updated_at", "user_id" ]
    end

    def self.ransackable_associations(auth_object = nil)
      [ "comments", "favorites", "user" ]
    end
end
