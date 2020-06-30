class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :quit, :invalid]
  before_action :set_data, only: [:show]
  before_action :new_component, only: [:show]
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :refuse_wrong_user, only: [:edit, :update, :quit, :invalid]
  before_action :refuse_test_user, only: [:update, :invalid]

  def index
    @q = User.ransack(params[:q])
    users = @q.result.includes(
      :expressions, :reviews, :relationships,
      :trustings, :reverse_of_relationships, :trusteds
    )
    @users = pagination(users)
  end

  def show
    # ログインユーザに限りDM機能に関する変数を取得
    if user_signed_in?
      user_entry = Entry.where(user_id: @user.id).pluck(:room_id)
      current_user_entry = Entry.where(user_id: current_user.id).pluck(:room_id)
      # 配列の共通化によりroom_idを洗い出す
      @room_id = user_entry & current_user_entry
      if @room_id.blank?
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "USER情報が更新されました！"
    else
      render :edit
    end
  end

  def invalid
    @user.update(is_valid: false)
    reset_session
    redirect_to root_path, notice: "退会手続きができました。FrePreはあなたの再登録をお待ちしてます！"
  end

  def trust_user
    if params[:trusting]
      @user = User.find_by(optional_id: params[:trusting])
      users = @user.trustings.order(created_at: :desc)
    else
      @user = User.find_by(optional_id: params[:trusted])
      users = @user.trusteds.order(created_at: :desc)
    end
    @users = pagination(users)
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation,
      :introduction, :avatar, :optional_id, :is_valid
    )
  end

  def set_user
    @user = User.find_by(optional_id: params[:optional_id])
  end

  def new_component
    @component = Component.new
  end

  def set_data
    @user = User.find_by(optional_id: params[:optional_id])
    components = Component.where(user_id: @user.id).includes(:user, :taggings)
    expressions = Expression.where(user_id: @user.id)
    @components = arrange_com(components)
    @expressions = arrange_exp(expressions)
  end

  def pagination(users)
    users.page(params[:page]).per(10)
  end

  def refuse_wrong_user
    if current_user != @user
      redirect_to root_path, alert: "権限がありません。"
    end
  end

  def refuse_test_user
    # 本番環境でテストユーザに情報更新をさせない
    if Rails.env.production?
      tester = User.find_by(optional_id: 'testtester')
      if @user == tester
        redirect_to root_path, alert: "その操作は許可されていません！"
      end
    end
  end
end
