class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  def new; end

  # request password reset.
  # you get here when the user entered their email in the reset password form and submitted it.
  def create
    @user = User.find_by(email: params[:email])

    if @user
      @user.deliver_reset_password_instructions!
    else
      Rails.logger.warn "Password reset requested for non-existent email: #{params[:email]}"
    end

    redirect_to login_path, success: t(".success")
  end

  # This is the reset password form.
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    return if @user.present?

    not_authenticated
    nil
  end

  # This action fires when the user has sent the reset password form.
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    # the next line makes the password confirmation validation work
    @user.password_confirmation = params[:user][:password_confirmation]
    # the next line clears the temporary token and updates the password
    if @user.change_password(params[:user][:password])
      redirect_to(login_path, success: t(".success"))
    else
      render action: "edit"
    end
  end
end
