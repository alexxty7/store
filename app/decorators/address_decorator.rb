class AddressDecorator < Draper::Decorator
  delegate_all
  delegate :address

  def full_name
    "#{object.firstname} #{object.lastname}"
  end
end
