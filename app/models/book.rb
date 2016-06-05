class Book < ApplicationRecord
  validates :title, :price, :in_stock, presence: true

  belongs_to :author
  has_many :order_items

  mount_uploader :cover, CoverUploader

  def self.best_sellers
    joins(:order_items)
      .select('books.*, sum(order_items.quantity) as qty')
      .group(:id)
      .order('qty DESC')
  end
end
