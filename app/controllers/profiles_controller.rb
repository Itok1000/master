class ProfilesController < ApplicationController
    before_action :set_user, only: %i[edit update]

    def edit
      @user = User.find(current_user.id)
    end

    def update
      Rails.logger.debug do
        "user_params: #{user_params.inspect}" # ここでパラメーターをログに出力
      end
      if @user.update(user_params)
        redirect_to profile_path, success: t("defaults.flash_message.updated", item: User.model_name.human)
      else
        flash.now["danger"] = t("defaults.flash_message.not_updated", item: User.model_name.human)
        render :edit, status: :unprocessable_entity
      end
    end

    def show
      @user = User.find(current_user.id)
    end

    private

    def set_user
      @user = User.find(current_user.id)
    end

    def user_params
      params.require(:user).permit(:email, :user_name)
    end
end
