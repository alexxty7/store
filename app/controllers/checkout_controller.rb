class CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :check_order
  before_action :place_order_on_confirm, only: :show

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @checkout_form = CheckoutForm.new(checkout_form_params)
    render_wizard
  end

  def update
    @checkout_form = CheckoutForm.new(checkout_form_params)
    render_wizard(@checkout_form)
  end

  private

  def place_order_on_confirm
    return unless step == :complete
    current_order.place_order!
    session[:order_id] = nil
  end

  def check_order
    redirect_to cart_path if current_order.empty?
  end

  def checkout_form_params
    params
      .fetch(:checkout_form, {})
      .permit(
        :use_billing,
        :shipment_id,
        billing_address_attributes: address_attributes,
        shipping_address_attributes: address_attributes,
        credit_card_attributes: [:number, :month, :year, :cvv])
      .merge(
        order: current_order,
        step: step
      )
  end

  def address_attributes
    %i(id firstname lastname address zipcode city phone country_id)
  end
end
