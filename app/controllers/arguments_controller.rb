class ArgumentsController < ApplicationController
  before_action :new_expression, only: [:show]

  def index
    @argument = Argument.new
    @check = Check.new
    @q = Argument.ransack(params[:q])
    # タグの絞り込みがあれば
    if params[:tag]
      @arguments = Argument.includes(:taggings).tagged_with(params[:tag]).order(created_at: :desc).page(params[:page]).per(10)
    # targetカラムの絞り込みがあれば
    elsif params[:target]
      @arguments = Argument.includes(:taggings).where(target: params[:target]).order(created_at: :desc).page(params[:page]).per(10)
    # ransack検索結果 & 全件表示
    else
      @arguments = @q.result.includes(:taggings).order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def create
    @argument = Argument.new(argument_params)
    if @argument.save
      redirect_to @argument, notice: "ARGUMENTが投稿できました！早速EXPRESSIONを書きましょう！"
    else
      @q = Argument.ransack(params[:q])
      render :index
    end
  end

  def show
    @argument = Argument.find(params[:id])
    @event = Event.new
  end

  private

  def argument_params
    params.require(:argument).permit(:topic, :target, :tag_list)
  end
end
