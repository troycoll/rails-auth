# frozen_string_literal: true

# class PasswordResetsController allows the user to reset their password
class PasswordResetsController < ApplicationController
  def new; end

  # finds user with a valid token
  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_in_path, alert: 'Your token has expired. Please try again.'
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present?
      # send mail
      PasswordMailer.with(user: @user).reset.deliver_later
      # deliver_later is provided by ActiveJob
    end
    redirect_to root_path, notice: 'Please check your email for the reset notification'
  end

  def update
    # updates user's password
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
    if user.update(password_params)
      redirect_to sign_in_path, notice: 'Your password was reset successfully. Please sign in.'
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
