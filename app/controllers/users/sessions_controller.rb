# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

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

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:optional_id])
  end
end
