class ComponentsController < ApplicationController
  before_action :set_component, only: [:edit, :update, :destroy]

  def index
    # view側からの絞り込みに対応してインスタンス変数化
    if params[:tag]
      components = Component.tagged_with(params[:tag]).includes(:user, :taggings)
    elsif params[:kind_of]
      components = Component.where(kind_of: params[:kind_of]).includes(:user, :taggings)
    else
      components = Component.all.includes(:user, :taggings)
    end
    @components = arrangement(components)
  end

  def create
    @component = Component.new(component_params)
    @user = @component.user
    if @component.save
      redirect_to @user, notice: "COMPONENTが投稿されました！"
    else
      # render用のデータを取得するためのメソッド
      get_data
      render 'users/show'
    end
  end

  def update
    if @component.update(component_params)
      redirect_to user_path(current_user), notice: "COMPONENTが更新されました！"
    else
      render :edit
    end
  end

  def destroy
    @component.destroy
    redirect_to current_user
  end

  private

  def component_params
    params.require(:component).permit(
      :kind_of, :title, :description, :user_id, :tag_list
    )
  end

  def set_component
    @component = Component.find(params[:id])
  end

  def get_data
    components = Component.where(user_id: @user.id).includes(:user, :taggings)
    expressions = Expression.where(user_id: @user.id)
    @components = arrange_com(components)
    @expressions = arrange_exp(expressions)
  end

  def arrangement(components)
    components.order(created_at: :desc).page(params[:page]).per(12)
  end
end
