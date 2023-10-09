# frozen_string_literal: true

def show_details(product)
  puts "Code: #{product.code}"
  puts "Name: #{product.name}"

  currency = case product.currency
             when 'euro'
               '€'
             end

  puts "Price: #{product.price}#{currency} \n\n"
end
