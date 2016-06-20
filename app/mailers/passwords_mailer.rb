# Authentication Mailer class
class PasswordsMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.passwords_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = User.find user.id
    mail(to: user.email)
  end
end
