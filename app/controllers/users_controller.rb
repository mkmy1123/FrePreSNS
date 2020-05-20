class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @component = Component.new
    @components = Component.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :avatar,  :optional_id)
    end

end
