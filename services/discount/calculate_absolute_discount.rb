# frozen_string_literal: true

class CalculateAbsoluteDiscount
  def initialize(product, count, discount)
    @product = product
    @count = count
    @discount = discount
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    value = 0

    value = @discount.value * @count if @count >= @discount.count

    value
  end
end
