class OauthsController < ApplicationController
    skip_before_action :require_login
    def oauth
       Rails.logger.debug "OAuth Provider: #{auth_params[:provider]}"
      login_at(auth_params[:provider])
    end
    def callback
      provider = auth_params[:provider]
       Rails.logger.debug "Callback Provider: #{provider}"
       Rails.logger.debug "Redirect URI: #{ENV['GOOGLE_CALLBACK_URL']}"
      if (@user = login_from(provider))
        Rails.logger.debug "User logged in successfully: #{@user.inspect}"
        reset_session
        auto_login(@user)
        redirect_to root_path, success: t("oauths.login_success")
      else
        begin
          Rails.logger.debug "User not found, signing up"
          sign_up_and_login_from(provider)
          redirect_to root_path, success: t("oauths.login_success")
        rescue => e
          Rails.logger.error "#{t("oauths.login_failure")}: #{e.message}"
          Rails.logger.error "バックトレース: #{e.backtrace.join("\n")}"
          redirect_to root_path, danger: t("oauths.login_failure")
        end
      end
    end
    private
    def auth_params
      params.permit(:code, :provider)
    end
    def sign_up_and_login_from(provider)
      @user = create_from(provider)
      auto_login(@user)
    end
end
