# frozen_string_literal: true

class CalculatePercentDiscount
  def initialize(product, count)
    @product = product
    @count = count
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    value = 0

    value = @product.percent_discount * @product.price * @count if @count >= @product.min_count_discount

    value
  end
end
