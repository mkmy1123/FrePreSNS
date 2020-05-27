class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @component = Component.new
    @components = Component.where(user_id: @user.id).order(created_at: :desc).page(params[:page_com]).per(8)
    @expressions = Expression.where(user_id: @user.id).order(created_at: :desc).page(params[:page_exp]).per(7)
  end

  def edit
  end

  def update
    @user.update(user_params)
  end

  def trust_user
    if params[:trusting]
      @user = User.friendly.find(params[:trusting])
      @users = @user.trustings
    else
      @user = User.friendly.find(params[:trusted])
      @users = @user.trusteds
    end
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :avatar, :optional_id)
  end
end
