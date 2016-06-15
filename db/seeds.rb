# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Book.destroy_all
# Category.destroy_all
# Author.destroy_all
# Category.destroy_all

# Category.create!(
#   [
#     { name: 'Fiction' },
#     { name: 'History' },
#     { name: 'Business' },
#     { name: 'Classics' },
#     { name: 'Fantasy' },
#     { name: 'Mystery' },
#     { name: 'Thriller' }
#   ]
# )
# author = Author.create(
#   first_name: FFaker::Name.first_name,
#   last_name: FFaker::Name.last_name,
#   biography: FFaker::Lorem.paragraph
# )

# 50.times do
#   Book.create!(
#     title: FFaker::Product.product_name,
#     description: FFaker::Lorem.paragraph,
#     price: rand(1000) + 1,
#     in_stock: rand(5..10),
#     author: author,
#     category: Category.order('RANDOM()').first
#   )
# end

# p "Created #{Book.count} books"
# p "Created #{Author.count} authors"
# Coupon.create!(
#   code: 'QWERTY',
#   discount: 5,
#   starts_at: Date.new(2014, 5, 12),
#   expires_at: Date.new(2018, 5, 12)
# )
# Coupon.create!(
#   code: 'QWERTY11',
#   discount: 5,
#   starts_at: Date.new(2017, 5, 12),
#   expires_at: Date.new(2018, 5, 12)
# )
# p "Created #{Coupon.count} coupons"
10.times { Country.create(name: FFaker::Address.country) }
3.times { Shipment.create!(name: FFaker::Product.product_name, price: rand(5..15)) }