require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome_mail" do
    let(:mail) { UserMailer.welcome_mail }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome mail")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
