# frozen_string_literal: true

# dependencies
require 'readline'
require 'json'

require_relative 'models/product'
require_relative 'helpers/product_helper'
require_relative 'services/calculate_basket_price'

INPUT_FILE = 'input.json'

puts '-----------------'
puts "Products will be got from #{INPUT_FILE} file"
puts 'Continue? Press the key (y/n)'

# handle interruption by Ctrl^C command
stty_save = `stty -g`.chomp
trap('INT') do
  system 'stty', stty_save
  exit
end

buf = Readline.readline('> ', true)
exit if buf == 'n'

# read from file
file = File.read("./#{INPUT_FILE}")
data = JSON.parse(file)

require 'pry'
products = data['products']
products_array = []
products_code_hash = {}

i = 0
products.each do |product|
  new_product = Product.new(product['code'], product['name'], product['price'], product['currency'],
                            product['discount'])
  products_array << new_product
  products_code_hash[new_product.code] = i
  show_details(new_product)
  i += 1
end

puts 'Add products to the basket. Enter each product by it\'s code and press Enter'
puts "To finish add products type 'end'"
basket = []

while buf = Readline.readline('> ', true)
  break if buf == 'end'

  if products_code_hash[buf].nil?
    puts 'There is no such product registered'
  else
    basket << buf
  end
end

puts "Basket is: #{basket.join(',')}"

# calculate basket price
result = CalculateBasketPrice.call(basket, products_array)
unless result.success?
  puts "Error message: #{result.message}"
  exit
end

puts "Total price: #{result.price}#{get_currency_sign('euro')}"
