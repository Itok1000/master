class ImagesController < ApplicationController
  skip_before_action :require_login, raise: false

  def ogp
    text = ogp_params[:text]
    # 画像に表示させたいテキストを取得
    image = OgpCreator.build(text).tempfile.open.read
    # OgpCreatorが表示させたいテキストを追加した画像を作成
    # それをblobという形式で取得
    send_data image, type: "image/png", disposition: "inline"
    # blob形式の画像をpngファイルとして、レンダリング
  end

  private

  def ogp_params
    params.permit(:text)
  end
end
