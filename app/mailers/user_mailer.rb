class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user_id)
    @user = User.find(user_id)
    @shopping_list = @user.shopping_list
    mail(to: @user.email, subject: 'Your shopping list')
  end
end

