# Omniauthを正しく動作させるために、以下を追加
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2,
             Rails.application.credentials.dig(:google, :client_id),
             Rails.application.credentials.dig(:google, :client_secret)
end
# この設定は、OmniauthがGoogle認証の設定を利用できるようにする
