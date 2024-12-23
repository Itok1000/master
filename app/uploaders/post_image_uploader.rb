# CarrierWaveでは、アップロードされたファイルが存在しない場合に、このメソッドで定義されたURLを使用してデフォルトの画像を表示
class PostImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick

  # CarrierWaveのMiniMagick拡張機能を利用
  # mini_magickを使って画像を300x200にリサイズ
  include CarrierWave::MiniMagick # MiniMagickを使うためのインクルード

  # Choose what kind of storage to use for this uploader:
  # Rails.env.production? の場合(つまり本番環境)で storage :fog を使用し、それ以外の環境（開発・テスト）では storage :file するように条件分岐させ
  if Rails.env.production?|| Rails.env.test?
    storage :fog
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_allowlist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end


  # extension_allowlist メソッド
  # CarrierWave で許可されるファイル拡張子のリストを指定するために使用
  def extension_allowlist
    %w[jpg jpeg gif png]
  end
  # アップロードできるファイルの種類を制限し、セキュリティとデータの整合性を確保する
  # 上記コードでいえば、extension_allowlistメソッド に %w[jpg jpeg gif png] を指定することで、
  # アップロード可能なファイル形式を jpg、jpeg、gif、png のみに制限し、
  # 想定外のファイル形式がアップロードされるのを防ぐことができる

  # WebPに変換
  process :convert_to_webp

  def convert_to_webp
    manipulate! do |img|
      img.format "webp"
      img
    end
  end
  # 拡張子を.webpで保存
  def filename
    super.chomp(File.extname(super)) + ".webp" if original_filename.present?
  end


  # board_imageカラムに値が無い場合は、300 x 200 画像（board_placeholder.png）を表示するように設定
  def default_url(*args)
    ActionController::Base.helpers.asset_path("post_placeholder.webp") # 拡張子に合わせて修正
  end

  # 画像を300x200にリサイズして切り抜き
  version :thumb do
    process resize_to_fill: [ 300, 200 ]  # 300x200で切り抜く
  end
  # resize_to_fillメソッドは、画像を指定のサイズに切り抜く処理
  # 300x200の比率に合わせて、必要に応じて中央を基準に余分な部分をトリミングする
end
