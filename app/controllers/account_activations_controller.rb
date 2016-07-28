class AccountActivationsController < ApplicationController
  before_create :create_activation_digest

  def edit
    user = User.find_by(email: params[:email])
    if user && !user_activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      login user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

  private
  def create_activation_digest

  end
end
