class SessionsController < ApplicationController
    def create
      if user
        session[:user_id] = user.id
        redirect_to root_url, notice: t("notices.login_success")
      else
        flash.now.alert = t("alerts.invalid_credentials")
        render :new
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_url, notice: t("notices.logout_success")
    end
end
