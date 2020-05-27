class RelationshipsController < ApplicationController

  before_action :set_user, only: [:create, :destroy]

  def index
    @users = current_user.trustings
    @expressions = Expression.where(user_id: @users).order("created_at DESC")
  end

  def create
    trusting = current_user.trust(@user)
    if trusting.save
      flash[:notice] = 'このUSERを信用しました！これからよろしくお願いします！'
      redirect_to @user
    else
      flash.now[:alert] = 'このUSERの信用に失敗しました...'
      redirect_to @user
    end
  end

  def destroy
    trusting = current_user.untrust(@user)
    if trusting.destroy
      flash[:notice] = 'さようなら！このUSERの信用をなかったことにしました！'
      redirect_to @user
    else
      flash.now[:alert] = 'このUSERの信用を外すのに失敗しました...'
      redirect_to @user
    end
  end

  private

  def set_user
    @user = User.find(params[:relationship][:trust_id])
  end
end
