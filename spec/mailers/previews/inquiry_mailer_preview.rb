# Preview all emails at http://localhost:3000/rails/mailers/inquiry
class InquiryMailerPreview < ActionMailer::Preview
  def inquiry
    inquiry = Inquiry.new(problemUrl: "https://frepresns.com", content: "問い合わせメッセージ", email: "test@test.com")

    InquiryMailer.send_mail(inquiry)
  end
end
