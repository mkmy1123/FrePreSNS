if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    user_name: ENV['EMAIL'],
    password: ENV['EMAIL_PASS'],
    authentication: 'plain',
    enable_starttls_auto: true
  }
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
else
  ActionMailer::Base.delivery_method = :test
end
