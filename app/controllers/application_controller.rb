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
    if optional_id == 'testtester'
      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end
end
