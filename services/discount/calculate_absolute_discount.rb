# frozen_string_literal: true

class CalculateAbsoluteDiscount
  def initialize(product, count)
    @product = product
    @count = count
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    value = 0

    value = @product.absolute_discount * @count if @count >= @product.min_count_discount

    value
  end
end
