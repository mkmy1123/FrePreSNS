class ExpressionsController < ApplicationController
  before_action :set_expression, only: [:edit, :show, :update, :destroy]
  before_action :set_argument, only: [:edit, :show, :update]
  before_action :new_expression, only: [:create]

  def index
    # 絞り込みがあれば
    if params[:argument_id]
      # そのARGUMENTをインスタンス変数に
      find_argument(params[:argument_id])
      expressions = Expression.where(argument_id: @argument.id).includes(:reviews, :user)
      # position_ofカラムに合わせてEXPRESSIONをインスタンス変数化
      set_position(expressions)
    else
      expressions = Expression.includes(:reviews, :user).all
      set_position(expressions)
    end
  end

  def edit
  end

  def create
    @expression = Expression.new(expression_params)
    @expression.user_id = current_user.id
    # インスタンス変数化
    find_argument(@expression.argument_id)
    if @expression.save
      @argument.create_notification_checkedEexpression!(current_user, @expression.id)
      redirect_to @expression, notice: "おめでとうございます、無事EXPRESSIONが生まれました！"
    else
      @event = Event.new
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
      render :edit
    end
  end

  def destroy
    @expression.destroy
    redirect_to expressions_path, notice: "綺麗さっぱり EXPRESSION はなかったことになりました！"
  end

  private

  def expression_params
    params.require(:expression).permit(:position_of, :statement, :detail, :argument_id)
  end

  def set_expression
    @expression = Expression.find(params[:id])
  end

  def set_argument
    @argument = Argument.find(@expression.argument_id)
  end

  def neutral(expressions)
    expressions.where(position_of: 0).order(created_at: "DESC").page(params[:neutral]).per(7)
  end

  def positive(expressions)
    expressions.where(position_of: 1).order(created_at: "DESC").page(params[:positive]).per(7)
  end

  def negative(expressions)
    expressions.where(position_of: 2).order(created_at: "DESC").page(params[:negative]).per(7)
  end

  def set_position(expressions)
    # 上記３メソッドとセット
    @neutral_expressions = neutral(expressions)
    @positive_expressions = positive(expressions)
    @negative_expressions = negative(expressions)
  end
end
