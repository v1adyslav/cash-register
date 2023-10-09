# frozen_string_literal: true

require 'readline'
require 'json'

INPUT_FILE = 'input.json'

puts '-----------------'
puts "Products will be got from #{INPUT_FILE} file"
puts 'Continue? Press the key (y/n)'

stty_save = `stty -g`.chomp
trap('INT') do
  system 'stty', stty_save
  exit
end

buf = Readline.readline('> ', true)
exit if buf == 'n'

file = File.read("./#{INPUT_FILE}")
data = JSON.parse(file)

products = data['products']

products.each do |product|
  puts "Code: #{product['code']}"
  puts "Name: #{product['name']}"

  currency = case product['currency']
             when 'euro'
               '€'
             end

  puts "Price: #{product['price']}#{currency} \n\n"
end
