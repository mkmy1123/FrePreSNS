class ComponentsController < ApplicationController
  before_action :set_component, only: [:edit, :update, :destroy]

  def index
    if params[:tag]
      @components = Component.tagged_with(params[:tag]).order(created_at: :desc).page(params[:page]).per(12)
    else
      @components = Component.all.order(created_at: :desc).page(params[:page]).per(12)
    end
  end

  def create
    component = Component.new(component_params)
    if component.save
      redirect_to component.user
    else
      render 'users/show'
    end
  end

  def edit
  end

  def update
    if @component.update(component_params)
      redirect_to user_url(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    @component.destroy
    redirect_to current_user
  end

  private

  def component_params
    params.require(:component).permit(:kind_of, :title, :description, :user_id, :tag_list)
  end

  def set_component
    @component = Component.find(params[:id])
  end
end
