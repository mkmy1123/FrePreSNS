class RelationshipsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]
  before_action :authenticate_user!

  def index
    @users = current_user.trustings
    @expressions = Expression.where(user_id: @users).order("created_at DESC")
  end

  def create
    trusting = current_user.trust(@user)
    @user.create_notification_trust!(current_user)
    if trusting.save
      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.js { flash.now[:notice] = "このUSERを信用しました！これからよろしくお願いします！" }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.js { flash.now[:alert] = "Error!ブラウザの再読み込みをお試しください" }
      end
    end
  end

  def destroy
    trusting = current_user.untrust(@user)
    if trusting.destroy
      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.js { flash.now[:notice] = "さようなら！このUSERの信用をなかったことにしました！" }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.js { flash.now[:alert] = "Error!ブラウザの再読み込みをお試しください" }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:relationship][:trust_id])
  end
end
