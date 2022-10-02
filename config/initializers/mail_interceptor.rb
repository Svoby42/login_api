options = { forward_emails_to: "intercepted@#{ENV['DOMAIN']}",
            deliver_emails_to: ["test@#{ENV['DOMAIN']}"]}

unless Rails.env.test? || Rails.env.production?
  interceptor = MailInterceptor::Interceptor.new(options)
  ActionMailer::Base.register_interceptor(interceptor)
end