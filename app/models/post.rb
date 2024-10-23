class Post < ApplicationRecord
    # validatesメソッドは、各カラムにバリデーションを設定するために使用
    # presence: trueは値が空でないことを確認し、length: { maximum: *** } は文字数の最大値を制限する
    validates :title, presence: true, length: { maximum: 255 }
    # 65_535という書き方は、数値を読みやすくするためにアンダースコアを使用しており、これは65,535と同じ意味
    validates :body, presence: true, length: { maximum: 65_535 }
    # belongs_to :userとは、BoardモデルがUserモデルに属していることを示す。
    # この記述により、Boardモデルの各レコードはUserモデルのレコードに関連付けられることになる
    belongs_to :user
end
