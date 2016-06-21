class Users::AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @orders_in_progress = @user.orders.in_progress.first
    @orders_in_queue = @user.orders.in_queue
    @orders_in_delivery = @user.orders.in_delivery
    @orders_delivered = @user.orders.delivered
  end

  def edit
  end

  def update
    if @user.update(user_account_params)
      flash[:notice] = 'Account was successfully updated.'
      redirect_to edit_account_path
    else
      render :edit
    end
  end

  def update_password
    if @user.update_with_password(user_account_params)
      sign_in @user, bypass: true
      flash[:notice] = 'Password was successfully updated.'
      redirect_to edit_account_path
    else
      render :edit
    end
  end

  private

  def user_account_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :current_password,
      billing_address_attributes: address_attributes,
      shipping_address_attributes: address_attributes
    )
  end

  def set_user
    @user = current_user
  end

  def address_attributes
    %i(firstname lastname address zipcode city phone country_id)
  end
end
