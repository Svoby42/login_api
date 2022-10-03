class UserMailer < ApplicationMailer
  default from: "noreply@#{ENV['DOMAIN']}"

  def welcome(user)
    mail(to: user.email,
         subject: "Vítejte",
         template_name: 'welcome')
  end
end
