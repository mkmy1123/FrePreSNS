class InquiryMailer < ApplicationMailer

  def send_mail(inquiry)
    @inquiry = inquiry
    mail(
      to:   ENV['EMAIL'],
      subject: 'お問い合わせ通知'
    )
  end

end
