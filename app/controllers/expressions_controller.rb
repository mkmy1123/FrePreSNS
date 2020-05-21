class ExpressionsController < ApplicationController
  def index
    @expressions = Expression.all
    @positive_expressions = Expression.where(is_argument: true)
    @negative_expressions = Expression.where(is_argument: false)
    @neutral_expressions = Expression.where(is_argument: nil)
    @arguments = Argument.all
  end

  def edit
  end

  def create
    expression = Expression.new(expression_params)
    expression.user_id = current_user.id
    if expression.save
      redirect_to '/expressions'
    else
      render 'arguments/index'
    end
  end

  def show
    @expression = Expression.find(params[:id])
    @argument = Argument.find(@expression.argument_id)
  end

  def update
  end

  def destroy
  end

  private

  def expression_params
    params.require(:expression).permit(:is_argument, :statement, :detail, :argument_id)
  end
end
