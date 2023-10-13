# frozen_string_literal: true

class Product
  attr_accessor :code, :name, :price, :currency,
                :discount_type,
                :count_discount, :free_gift,
                :min_count_discount, :percent_discount, :absolute_discount

  def initialize(code, name, price, currency, discount)
    @code = code
    @name = name
    @price = price
    @currency = currency

    @discount_type = discount['type']
    case discount['type']
    when 'free'
      @count_discount = discount['count']
      @free_gift = discount['free']
    when 'absolute'
      @min_count_discount = discount['min_count']
      @absolute_discount = discount['absolute']
    when 'percent'
      @min_count_discount = discount['min_count']
      @percent_discount = discount['percent']
    end
  end
end
