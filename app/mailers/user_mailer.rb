class UserMailer < ApplicationMailer
  # default from: "noreply@#{ENV['DOMAIN']}"
  default from: ENV['SMTP_USERNAME']

  def welcome(user)
    mail(to: user.email,
         subject: "Vítejte",
         template_name: 'welcome')
  end
end
