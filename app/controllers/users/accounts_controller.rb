module Users
  class AccountsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, except: [:show]

    def show
      @history = OrderHistory.new(current_user)
    end

    def edit
    end

    def update
      if @user.update(user_account_params)
        flash[:notice] = t('account.flashes.account_updated')
        redirect_to edit_account_path
      else
        render :edit
      end
    end

    def update_password
      if @user.update_with_password(user_account_params)
        sign_in @user, bypass: true
        flash[:notice] = t('account.flashes.password_updated')
        redirect_to edit_account_path
      else
        render :edit
      end
    end

    private

    def set_user
      @user = current_user
    end

    def user_account_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :current_password,
        billing_address_attributes: address_attributes,
        shipping_address_attributes: address_attributes
      )
    end

    def address_attributes
      %i(firstname lastname address zipcode city phone country_id)
    end
  end
end
