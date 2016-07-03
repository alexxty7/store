class ReviewDecorator < Drape::Decorator
  delegate_all

  def author
    object.user.username || object.user.email
  end

  def created_at
    h.time_tag(object.created_at.to_date)
  end
end
