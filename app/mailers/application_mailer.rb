# Base Application Mailer Class
class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{ENV.fetch('DOMAIN')}"
  layout 'mailer'
end
