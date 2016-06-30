class BookDecorator < Drape::Decorator
  delegate_all

  decorates_association :author
end
