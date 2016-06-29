class BookDecorator < Draper::Decorator
  delegate_all

  decorates_association :author
end
