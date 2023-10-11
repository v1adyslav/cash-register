# frozen_string_literal: true

class Product
  attr_accessor :code, :name, :price, :currency,
                :count_discount, :free_gift,
                :min_count_discount, :percent_discount, :absolute_discount

  def initialize(code, name, price, currency, discount)
    @code = code
    @name = name
    @price = price
    @currency = currency

    unless discount['count'].nil?
      @count_discount = discount['count']
      @free_gift = discount['free']
    end

    unless discount['min_count'].nil?
      @min_count_discount = discount['min_count']
      @absolute_discount = discount['absolute'] unless discount['absolute'].nil?
      @percent_discount = discount['percent'] unless discount['percent'].nil?
    end
  end
end
