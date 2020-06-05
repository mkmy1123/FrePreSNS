# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome_mail
  def user
    user = User.new(optional_id: "test0001", name: "テスト太郎", email: "test@test.com")

    UserMailer.welcome_mail(user)
  end
end
