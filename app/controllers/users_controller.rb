class UsersController < ApplicationController
  before_action :set_user, only: %i[show update]

  def show
  end

  def update
    if @user.update(user_params)
      render :show
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :mobile, :password, :password_confirmation, :weixin_id,
      :nickname, :gender, :birthday
    )
  end
end
