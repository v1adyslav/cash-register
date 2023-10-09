# frozen_string_literal: true

# dependencies
require 'readline'
require 'json'

require_relative 'models/product'
require_relative 'helpers/product_helper'

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


# require 'pry'
products = data['products']
products_array = []

products.each do |product|
  new_product = Product.new(product['code'], product['name'], product['price'], product['currency'])
  products_array << new_product
  show_details(new_product)
end


