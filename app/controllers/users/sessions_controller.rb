# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
    flash[:notice] = "ログイン成功です。FrePreの世界へようこそ！"
  end

  # DELETE /resource/sign_out
  def destroy
    super
    flash[:notice] = "ログアウトしました。またFrePreの世界で会いましょう！"
  end

  protected

  # optional_idにてログインさせる
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:optional_id])
  end

  def reject_user
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false))
        flash[:error] = "退会済みです。再登録をお願いします。"
        redirect_to new_user_session_path
      end
    else
      flash[:error] = "項目に誤りがあります。"
    end
  end
end
