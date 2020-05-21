class ArgumentsController < ApplicationController
  def index
    @argument = Argument.new
    @arguments = Argument.all
  end

  def create
    argument = Argument.new(argument_params)
    if argument.save
      redirect_to '/arguments'
    else
      render 'index'
    end
  end

  def show
    @argument = Argument.find(params[:id])
    @expression = Expression.new
  end

  private

  def argument_params
    params.require(:argument).permit(:topic, :target)
  end
end
