# frozen_string_literal: true

class CalculateAbsoluteDiscount
  def initialize(product, k)
    @product = product
    @k = k
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    value = 0

    if @k >= @product.min_count_discount
      value = @product.absolute_discount * @k
    end

    value
  end
end