class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  def new; end


  def create
    @user = User.find_by(email: params[:email])

    if @user
      @user.deliver_reset_password_instructions!
    else
      Rails.logger.warn "Password reset requested for non-existent email: #{params[:email]}"
    end

    redirect_to login_path, success: t(".success")
  end


  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    return if @user.present?

    not_authenticated
    nil
  end


  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end


    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.change_password(params[:user][:password])
      redirect_to(login_path, success: t(".success"))
    else
      render action: "edit"
    end
  end
end
