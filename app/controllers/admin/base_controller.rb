class Admin::BaseController < ApplicationController
    before_action :check_admin
    layout "admin/layouts/application"

    private

    def not_authenticated
      flash[:warning] = t("defaults.flash_message.require_login")
      redirect_to admin_login_path
    end

    def check_admin
      redirect_to root_path, danger: t("defaults.flash_message.not_authorized") unless current_user.admin?
    end
end
