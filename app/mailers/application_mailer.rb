class ApplicationMailer < ActionMailer::Base
  default from: "noreply@#{ENV['DOMAIN']}"
  layout "mailer"
end
