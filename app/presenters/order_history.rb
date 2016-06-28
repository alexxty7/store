class OrderHistory
  def initialize(user)
    @user = user
  end

  delegate :in_progress, :in_queue, :in_delivery, :delivered,
           to: :orders, prefix: true

  private

  def orders
    @_orders ||= @user.orders
  end
end
