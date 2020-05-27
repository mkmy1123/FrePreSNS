class ArgumentsController < ApplicationController

  before_action :new_expression, only: [:show]

  def index
    @argument = Argument.new
    @check = Check.new
    if params[:tag]
      @arguments = Argument.tagged_with(params[:tag]).order(created_at: :desc).page(params[:page]).per(10)
    else
      @arguments = Argument.all.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def create
    argument = Argument.new(argument_params)
    if argument.save
      redirect_to argument, notice: "ARGUMENTが投稿できました！早速EXPRESSIONを書きましょう！"
    else
      redirect_to arguments_path, alert: "ARGUMENTが投稿できませんでした！文字数を確認してください..."
    end
  end

  def show
    @argument = Argument.find(params[:id])
  end

  private

  def argument_params
    params.require(:argument).permit(:topic, :target, :tag_list)
  end
end
