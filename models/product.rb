# frozen_string_literal: true

class Product
  attr_accessor :code, :name, :price, :currency

  def initialize(code, name, price, currency)
    @code = code
    @name = name
    @price = price
    @currency = currency
  end
end
