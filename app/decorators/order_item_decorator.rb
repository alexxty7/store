class OrderItemDecorator < Drape::Decorator
  delegate_all

  def book_cover
    h.image_tag(object.book.cover.thumb, class: 'img-responsive')
  end
end
