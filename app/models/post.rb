class Post < ApplicationRecord
    # validatesメソッドは、各カラムにバリデーションを設定するために使用
    # presence: trueは値が空でないことを確認し、length: { maximum: *** } は文字数の最大値を制限する
    validates :title, presence: true, length: { maximum: 255 }
    # 65_535という書き方は、数値を読みやすくするためにアンダースコアを使用しており、これは65,535と同じ意味
    validates :body, presence: true, length: { maximum: 65_535 }
    # belongs_to :userとは、PostモデルがUserモデルに属していることを示す。
    # この記述により、Postモデルの各レコードはUserモデルのレコードに関連付けられることになる

    mount_uploader :post_image, PostImageUploader
    # 下記の記述を加えることで、Postモデルに対して CarrierWave の アップローダークラス（PostImageUploader）をマウントする
    # これにより、Postモデルのインスタンスで post_image という属性を持つことができ、画像のアップロードや取得が簡単に行えるようになる
    # また、上記を記述することにより、CarrierWave が提供するアップロードされた画像のURLを取得することができるようになる
    # (今回の課題の場合 post_image_url メソッドを使用して、画像のURLを取得できるようになる)
    # ※CarrierWaveがモデルに対して動的にメソッドを追加し、ファイルの保存場所やURLを管理する機能を提供するため

    # この設定により、Postモデルは画像のアップロード機能を持ち、ビューで画像を表示するためのURLを生成することが可能となる
    belongs_to :user
end
