class BookDecorator < Drape::Decorator
  delegate_all
  delegate :full_name, to: :author, prefix: true

  decorates_association :author
  decorates_association :reviews
end
