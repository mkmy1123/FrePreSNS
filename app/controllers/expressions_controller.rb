class ExpressionsController < ApplicationController
  def index
    @expressions = Expression.all
    @arguments = Argument.all
  end

  def edit
    @expression = Expression.find(params[:id])
    @argument = Argument.find(@expression.argument_id)
  end

  def create
    new_expression = Expression.new(expression_params)
    new_expression.user_id = current_user.id
    @argument = Argument.find(new_expression.argument_id)
    @expression = Expression.new
    if new_expression.save
      redirect_to new_expression, notice: "おめでとうございます、無事EXPRESSIONが生まれました！"
    else
      flash[:alert] = "EXPRESSIONの作成に失敗しました。要点の文字数を確認してください..."
      render "arguments/show"
    end
  end

  def show
    @expression = Expression.find(params[:id])
    @argument = Argument.find(@expression.argument_id)
  end

  def update
    @expression = Expression.find(params[:id])
    if @expression.update(expression_params)
      redirect_to @expression, notice: "ありがとうございます！EXPRESSION を更新しました！"
    else
      flash[:alert] = "EXPRESSIONの更新に失敗しました。内容を確認してください..."
      render 'edit'
    end
  end

  def destroy
    expression = Expression.find(params[:id])
    expression.destroy
    redirect_to expressions_path, notice: "綺麗さっぱり EXPRESSION はなかったことになりました！"
  end

  private

  def expression_params
    params.require(:expression).permit(:is_argument, :statement, :detail, :argument_id)
  end
end
