# frozen_string_literal: true

class Product
  attr_accessor :code, :name, :price, :currency, :discount_type

  def initialize(code, name, price, currency, discount)
    @code = code
    @name = name
    @price = price
    @currency = currency
    @discount_type = discount
  end
end
