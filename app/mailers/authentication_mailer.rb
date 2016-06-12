# Authentication Mailer class
class AuthenticationMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.authentication_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = User.find user.id
    @url  = api_password_reset_url(@user.reset_password_token)
    mail(to: user.email)
  end
end
