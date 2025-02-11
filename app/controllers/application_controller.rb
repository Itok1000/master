class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  
  before_action :require_login
 
  before_action :set_locale
  
  add_flash_types :success, :danger
  
  def default_url_options
    { locale: I18n.locale }
  end
  
  private

  def not_authenticated
    redirect_to login_path, danger: t("defaults.flash_message.require_login")
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
