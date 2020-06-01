class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :quit, :invalid]
  before_action :authenticate_user!, only: [:edit, :update]

  def show
    @component = Component.new
    @components = Component.where(user_id: @user.id).order(created_at: :desc).page(params[:page_com]).per(8)
    @expressions = Expression.where(user_id: @user.id).order(created_at: :desc).page(params[:page_exp]).per(7)
    @user_entry = Entry.where(user_id: @user.id)
    if user_signed_in?
      unless @user.id == current_user.id
        @current_user_entry = Entry.where(user_id: current_user.id)
        @current_user_entry.each do |cu|
          @user_entry.each do |u|
            if cu.room_id == u.room_id then
              @is_room = true
              @room_id = cu.room_id
            end
          end
        end
        unless @is_room
          if @user.trusting?(current_user) && current_user.trusting?(@user)
            @room = Room.new
            @entry = Entry.new
          end
        end
      end
    end
  end

  def edit
    if current_user != @user
      redirect_to @user
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "USER情報が更新されました！"
    else
      flash[:alert] = "USER情報が更新できませんでした..."
      render "edit"
    end
  end

  def quit
  end

  def invalid
    @user.update(is_valid: false)
    reset_session
    flash[:notice] = "退会手続きができました。FrePreはあなたの再登録をお待ちしてます！"
    redirect_to root_path
  end

  def trust_user
    if params[:trusting]
      @user = User.friendly.find(params[:trusting])
      @users = @user.trustings.order(created_at: :desc).page(params[:page]).per(10)
    else
      @user = User.friendly.find(params[:trusted])
      @users = @user.trusteds.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :avatar, :optional_id, :is_valid)
  end
end
