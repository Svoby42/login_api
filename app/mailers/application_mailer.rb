class ApplicationMailer < ActionMailer::Base
  # default from: "noreply@#{ENV['DOMAIN ']}"
  default "Message-ID" => "#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@svoby.eu"
  default from: ENV['SMTP_USERNAME']
  layout "mailer"
end
