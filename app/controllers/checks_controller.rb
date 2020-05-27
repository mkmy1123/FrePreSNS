class ChecksController < ApplicationController
  def index
    @checked_arguments = current_user.checks.all
  end

  def create
    @check = current_user.checks.create(argument_id: params[:argument_id])
    redirect_back(fallback_location: root_path)
    flash[:notice] = "ARGUMENT を CHECK しました！"
  end

  def destroy
    @check = Check.find_by(argument_id: params[:argument_id], user_id: current_user.id)
    @check.destroy
    redirect_back(fallback_location: root_path)
    flash[:notice] = "ARGUMENT の CHECK を外しました！"
  end
end
