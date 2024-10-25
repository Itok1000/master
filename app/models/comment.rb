class Comment < ApplicationRecord
  # 各コメントに複数のユーザーが「いいね」を付けられるため、「Comment」は「1対多」の関係になる
  belongs_to :user
  belongs_to :post
  validates :body, presence: true, length: { maximum: 65_535 }
end
