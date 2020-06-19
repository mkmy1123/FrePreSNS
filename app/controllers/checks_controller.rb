class ChecksController < ApplicationController
  before_action :authenticate_user!

  def index
    # ユーザのCHECK済み ARGUMENTをインスタンス変数化
    @arguments = current_user.checked_arguments
    # ARGUMENTの指定があれば限定してインスタンス変数化
    if params[:argument_id]
      get_expressions(params[:argument_id])
    else
      get_expressions(@arguments)
    end
    @expressions = arrangement(@expressions.includes(:user, :reviews))
  end

  def create
    @check = current_user.checks.create(argument_id: params[:argument_id])
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js { flash.now[:notice] = "ARGUMENT を CHECK しました！" }
    end
  end

  def destroy
    @check = Check.find_by(argument_id: params[:argument_id], user_id: current_user.id)
    @check.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js { flash.now[:alert] = "ARGUMENT の CHECK を外しました！" }
    end
  end

  private

  def arrangement(expressions)
    expressions.page(params[:page]).per(8)
  end
end
