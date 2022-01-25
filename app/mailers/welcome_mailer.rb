# frozen_string_literal: true

# sends a welcome email
class WelcomeMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url = 'http://locallhost:3000/sign_in'
    mail(to: @user.email, subject: 'Welcome to my awesome tutorial')
  end
end
