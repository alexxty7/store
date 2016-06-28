class OrderCalculator
  def initialize(order)
    @order = order
  end

  delegate :order_items, :shipment, :coupon, to: :order

  def subtotal
    order_items.inject(0) { |a, e| a + (e.price * e.quantity) }
  end

  def shipment_total
    shipment ? shipment.price : 0
  end

  def discount
    coupon ? coupon.discount : 0
  end

  def total
    subtotal + shipment_total - discount
  end

  private

  attr_reader :order
end
