require "carrierwave/storage/abstract"
require "carrierwave/storage/file"
require "carrierwave/storage/fog"

CarrierWave.configure do |config|
  if Rails.env.production? # 本番環境の場合はS3へアップロード
    config.storage :fog
    config.fog_directory  = "gamarjoba" # バケット名
    config.fog_public = false
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: ENV["S3_ACCESS_KEY_ID"], # アクセスキー
      aws_secret_access_key: ENV["S3_SECRET_ACCESS_KEY"], # シークレットアクセスキー
      region: "ap-northeast-1", # リージョン
      path_style: true
    }
  else # 本番環境以外の場合はアプリケーション内にアップロード
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end
