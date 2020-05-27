class ExpressionsController < ApplicationController

  before_action :set_expression, only: [:edit, :show, :update, :destroy]
  before_action :set_argument, only: [:edit, :show]
  before_action :new_expression, only: [:create]

  def index
    if params[:argument_id]
      find_argument(params[:argument_id])
      set_style(@argument.expressions)
    elsif params[:check]
      @arguments = current_user.checked_arguments
      set_style(@arguments.expressions)
    else
      expressions = Expression.all
      set_style(expressions)
    end
  end

  def edit
  end

  def create
    new_expression = Expression.new(expression_params)
    new_expression.user_id = current_user.id
    # render用の読み込み
    find_argument(new_expression.argument_id)
    if new_expression.save
      redirect_to new_expression, notice: "おめでとうございます、無事EXPRESSIONが生まれました！"
    else
      flash[:alert] = "EXPRESSIONの作成に失敗しました。要点の文字数を確認してください..."
      render "arguments/show"
    end
  end

  def show
    if user_signed_in?
      @review = Review.find_or_initialize_by(user_id: current_user.id, expression_id: @expression.id)
    end
  end

  def update
    if @expression.update(expression_params)
      redirect_to @expression, notice: "ありがとうございます！EXPRESSION を更新しました！"
    else
      flash[:alert] = "EXPRESSIONの更新に失敗しました。内容を確認してください..."
      render 'edit'
    end
  end

  def destroy
    @expression.destroy
    redirect_to expressions_path, notice: "綺麗さっぱり EXPRESSION はなかったことになりました！"
  end

  private

  def expression_params
    params.require(:expression).permit(:style, :statement, :detail, :argument_id)
  end

  def set_expression
    @expression = Expression.find(params[:id])
  end

  def neutral(expressions)
    expressions.where(style: 0).order(created_at: "DESC").page(params[:neutral]).per(7)
  end

  def positive(expressions)
    expressions.where(style: 1).order(created_at: "DESC").page(params[:positive]).per(7)
  end

  def negative(expressions)
    expressions.where(style: 2).order(created_at: "DESC").page(params[:negative]).per(7)
  end

  def set_style(expressions)
    @neutral_expressions = neutral(expressions)
    @positive_expressions = positive(expressions)
    @negative_expressions = negative(expressions)
  end

  def set_argument
    find_argument(@expression.argument_id)
  end
end
