class ApplicationMailer < ActionMailer::Base
  default from: "noreply@#{ENV['domain']}"
  layout "mailer"
end
