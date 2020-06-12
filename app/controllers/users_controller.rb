class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :quit, :invalid]
  before_action :set_data, only: [:show]
  before_action :new_component, only: [:show]
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :refuse_wrong_user, only: [:edit, :update, :quit, :invalid]
  before_action :refuse_test_user, only: [:update, :invalid]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.includes(:expressions, :reviews, :relationships, :trustings, :reverse_of_relationships, :trusteds).page(params[:page])
  end

  def show
    # DM機能に関する変数を取得
    @user_entry = Entry.where(user_id: @user.id)
    if user_signed_in?
      unless @user.id == current_user.id
        # @ユーザーが所属するroomを探すために変数化する
        @current_user_entry = Entry.where(user_id: current_user.id)
        @current_user_entry.each do |cu|
          @user_entry.each do |u|
            if cu.room_id == u.room_id
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
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "USER情報が更新されました！"
    else
      render :edit
    end
  end

  def quit
  end

  def invalid
    @user.update(is_valid: false)
    reset_session
    redirect_to root_path, notice: "退会手続きができました。FrePreはあなたの再登録をお待ちしてます！"
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

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :avatar, :optional_id, :is_valid)
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def new_component
    @component = Component.new
  end

  def set_data
    @user = User.friendly.find(params[:id])
    @components = Component.where(user_id: @user.id).includes(:user, :taggings).order(created_at: :desc).page(params[:page_com]).per(8)
    @expressions = Expression.where(user_id: @user.id).order(created_at: :desc).page(params[:page_exp]).per(7)
  end

  def refuse_wrong_user
    if current_user != @user
      redirect_to root_path, alert: "権限がありません。"
    end
  end

  def refuse_test_user
    tester = User.friendly.find('testtester')
    if @user == tester
      redirect_to root_path, alert: "その操作は許可されていません！"
    end
  end
end
