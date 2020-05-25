class ArgumentsController < ApplicationController
  def index
    @argument = Argument.new
    if params[:tag]
      @arguments = Argument.tagged_with(params[:tag])
    else
      @arguments = Argument.all
    end
    @check = Check.new
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
    @expression = Expression.new
  end

  private

  def argument_params
    params.require(:argument).permit(:topic, :target, :tag_list)
  end
end
