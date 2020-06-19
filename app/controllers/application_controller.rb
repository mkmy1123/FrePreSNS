class ApplicationController < ActionController::Base
  def find_argument(argument_id)
    @argument = Argument.find(argument_id)
  end

  def new_expression
    @expression = Expression.new
  end

  def get_expressions(argument)
    @expressions = Expression.where(argument_id: argument)
  end

  def check_guest
    # ゲストユーザーの情報変更を許可しない
    if optional_id == 'testtester'
      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end

  def arrange_com(components)
    components.order(created_at: :desc).page(params[:page_com]).per(8)
  end

  def arrange_exp(expressions)
    expressions.order(created_at: :desc).page(params[:page_exp]).per(7)
  end
end
