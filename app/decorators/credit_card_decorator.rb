class CreditCardDecorator < Drape::Decorator
  delegate_all

  def last_numbers
    "*** *** *** #{object.number.last(4)}"
  end

  def expiration_date
    "#{object.month}/#{object.year}"
  end
end
