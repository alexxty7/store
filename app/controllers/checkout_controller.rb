class CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :set_order
  before_action :check_order

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    if step == :complete
      session[:order_id] = nil
    end
    @order.setup_for_step(step)
    render_wizard
  end

  def update
    @order.update_attributes(checkout_params)
    render_wizard(@order)
  end

  private

  def set_order
    @order = current_order
  end

  def check_order
    redirect_to cart_path if @order.empty?
  end

  def checkout_params
    params
      .require(:order)
      .permit(
        :use_billing, 
        :shipment_id,
        billing_address_attributes: address_attributes,
        shipping_address_attributes: address_attributes,
        credit_card_attributes: [:number, :month, :year, :cvv]
      )
  end

  def address_attributes
    %i(firstname lastname address zipcode city phone country_id)
  end
end
