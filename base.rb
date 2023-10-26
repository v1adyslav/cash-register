# frozen_string_literal: true

require 'readline'
require 'json'

class Base
  INPUT_FILE = 'input.json'

  def self.cli
    load_files

    # read from file
    puts "Products will be got from #{INPUT_FILE} file"
    file = File.read("./#{INPUT_FILE}")
    data = JSON.parse(file)
    products = data['products']
    discounts = data['discounts']

    products_list = {}
    discounts_list = {}

    # process products input data
    products.each do |product|
      new_product = Product.new(product['code'], product['name'], product['price'], product['currency'],
                                product['discount'])
      products_list[new_product.code] = new_product
      show_details(new_product)
    end

    # process discounts input data
    discounts.each { |discount| discounts_list[discount['type']] = Discount.new(discount) }

    puts 'Add products to the basket. Enter each product by it\'s code and press Enter'
    puts "To finish add products type 'end'"
    basket = []
    while buf = Readline.readline('> ', true)
      break if buf == 'end'

      add_product_to_basket(buf, basket, products_list)
    end
    puts "Basket is: #{basket.join(',')}"

    # calculate basket price
    result = CalculateBasketPrice.call(basket, products_list, discounts_list)
    unless result.success?
      puts "Error message: #{result.message}"
      exit
    end

    puts "Total price: #{result.price}#{get_currency_sign('euro')}"
  end

  def self.load_files
    Dir["./models/**/*.rb"].each { |f| require f }
    Dir["./services/**/*.rb"].each { |f| require f }
    Dir["./helpers/**/*.rb"].each { |f| require f }
  end

  def self.add_product_to_basket(code, basket, products_list)
    if products_list[code].nil?
      puts 'There is no such product registered'
    else
      basket << code
    end
  end
end
