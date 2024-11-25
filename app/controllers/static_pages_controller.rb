require "rmagick"
# 読み込む画像ファイル名は適宜変更
# 変換したい画像のファイル名を配列に入れる
image_files = [
  "app/assets/images/atmosphere_tbilisi.png",
  "app/assets/images/Flag_of_Georgia.png",
  "app/assets/images/Image07.png",
  "app/assets/images/Georgia.png",
  "app/assets/images/Image02.png",
  "app/assets/images/Image06.png",
  "app/assets/images/Image07.png"
  # 他の画像ファイル名も追加
]

# 各画像をループで処理
image_files.each do |file|
  begin
    image = Magick::Image.read(file).first
    output_file = "#{File.basename(file, '.*')}.webp"  # 元のファイル名を使って出力ファイル名を生成
    image.write(output_file)
  end
end

class StaticPagesController < ApplicationController
    # トップページやジョージアページなどはログイン不要
    skip_before_action :require_login, only: %i[top georgia food how_to_use]
    def top; end
    # georgiaアクションを追加して、app/views/static_pages/georgia.html.erbをレンダリングするようにする
    def georgia; end
    # foodアクションを追加して、app/views/static_pages/georgia.html.erbをレンダリングするようにする
    def food; end
    # how_to_useアクションを追加して、app/views/static_pages/how_to_use.html.erbをレンダリングするようにする
    def how_to_use; end
end
