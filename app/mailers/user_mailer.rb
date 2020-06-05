class UserMailer < ApplicationMailer
  def welcome_mail(user)
    @user = user
    mail(
      to: @user.email,
      subject: 'FrePreSNSの世界へようこそ！'
    )
  end
end
